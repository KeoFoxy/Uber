//
//  HomeViewModel.swift
//  Uber
//
//  Created by Alexander Sorokin on 31.07.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine
import MapKit

class HomeViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published var drivers = [User]()
    @Published var trip: Trip?
    
    private let service = UserService.shared
    private var cancellable = Set<AnyCancellable>()
    private var currentUser: User?
    
    // MARK: - Location Search Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickUpTime: String?
    @Published var dropOffTime: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var userLocation: CLLocationCoordinate2D?
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        fetchUser()
        
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // MARK: - User API
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
                guard let user = user else { return }
                
                if user.accountType == .passenger {
                    self.fetchDrivers()
                    self.addTripObserverForPassenger()
                } else {
                    self.addTripObserverForDriver()
                }
            }
            .store(in: &cancellable)
    }
}

// MARK: - Passenger API

extension HomeViewModel {
    
    func addTripObserverForPassenger() {
        guard let currentUser = currentUser, currentUser.accountType == .passenger else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("passengerUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                guard let change = snapshot?.documentChanges.first,
                        change.type == .added ||
                        change.type == .modified else { return }
                guard let trip = try? change.document.data(as: Trip.self) else { return }
                self.trip = trip
                
                print("DEBUG: Update trip state is \(trip.state)")
            }
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccoutnType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let drivers = documents.compactMap({ try? $0.data(as: User.self) })
                self.drivers = drivers
            }
    }
    
    func requestTrip() {
        guard let driver = drivers.first else { return }
        guard let currentUser = currentUser else { return }
        guard let dropoffLocation = selectedUberLocation else { return }
        let dropoffGeoPoint = GeoPoint(latitude: dropoffLocation.coordinate.latitude, longitude: dropoffLocation.coordinate.longitude)
        let userLocation = CLLocation(latitude: currentUser.coordinates.latitude, longitude: currentUser.coordinates.longitude)
        
        getPlaceMark(forLocation: userLocation) { placemark, error in
            guard let placemark = placemark else { return }
            
            let tripCost = self.computeRidePrice(forType: .uberX)
            
            let trip = Trip(passengerUid: currentUser.uid,
                            driverUid: driver.uid,
                            passengerName: currentUser.fullname,
                            driverName: driver.fullname,
                            passengerLocation: currentUser.coordinates,
                            driverLocation: driver.coordinates,
                            pickupLocationName: placemark.name ?? "Current location",
                            dropoffLocationName: dropoffLocation.title,
                            pickupLocationAddress: self.addressFromPlacemark(placemark),
                            pickupLocation: currentUser.coordinates,
                            dropoffLocation: dropoffGeoPoint,
                            tripCost: tripCost,
                            tripDistance: 0,
                            tripDuration: 0,
                            state: .requested
            )
            
            guard let encodedTrip = try? Firestore.Encoder().encode(trip) else { return }
            Firestore.firestore().collection("trips").document().setData(encodedTrip) { _ in
                print("DEBUG: Did upload trip to upload")
            }
        }
    }
}

// MARK: - Driver API

extension HomeViewModel {
    
    func addTripObserverForDriver() {
        guard let currentUser = currentUser, currentUser.accountType == .driver else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("driverUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                guard let change = snapshot?.documentChanges.first,
                        change.type == .added ||
                        change.type == .modified else { return }
                guard let trip = try? change.document.data(as: Trip.self) else { return }
                
                self.trip = trip
                
                self.getDestinationRoute(from: trip.driverLocation.toCoordinate(),
                                         to: trip.pickupLocation.toCoordinate()) { route in
                    print("DEBUG: Expected travel time to passenger: \(Int(route.expectedTravelTime / 60))")
                    print("DEBUG: Distance from passenger \(route.distance.distanceInMilesString())")
                    
                    self.trip?.tripDuration = Int(route.expectedTravelTime / 60)
                    self.trip?.tripDistance = route.distance
                }
            }
    }
    
//    func fetchTrips() {
//        guard let currentUser = currentUser, currentUser.accountType == .driver else { return }
//
//        Firestore.firestore().collection("trips")
//            .whereField("driverUid", isEqualTo: currentUser.uid)
//            .getDocuments { snapshot, _ in
//                guard let documents = snapshot?.documents, let document = documents.first else { return }
//                guard let trip = try? document.data(as: Trip.self) else { return }
//
//                self.trip = trip
//
//                self.getDestinationRoute(from: trip.driverLocation.toCoordinate(),
//                                         to: trip.pickupLocation.toCoordinate()) { route in
//                    print("DEBUG: Expected travel time to passenger: \(Int(route.expectedTravelTime / 60))")
//                    print("DEBUG: Distance from passenger \(route.distance.distanceInMilesString())")
//
//                    self.trip?.tripDuration = Int(route.expectedTravelTime / 60)
//                    self.trip?.tripDistance = route.distance
//                }
//            }
//    }
    
    func rejectTrip() {
        updateTripState(state: .rejected)
    }
    
    func acceptTrip() {
        updateTripState(state: .accepted)
    }
    
    private func updateTripState(state: TripState) {
        guard let trip = trip else { return }
        
        var data = ["state": state.rawValue]
        
        if state == .accepted {
            data["tripDuration"] = trip.tripDuration
        }
        Firestore.firestore().collection("trips").document(trip.id).updateData(data) { _ in
            print("DEBUG: Did \(state) trip")
        }
    }
}

// MARK: - Location Search Helpers

extension HomeViewModel {
    
    func addressFromPlacemark(_ placemark: CLPlacemark) -> String {
        var result = ""
        
        if let thoroughfare = placemark.thoroughfare {
            result += thoroughfare
        }
        
        if let subthoroughfare = placemark.subThoroughfare {
            result += " \(subthoroughfare)"
        }
        
        if let subadministrativearea = placemark.subAdministrativeArea {
            result += ", \(subadministrativearea)"
        }
        
        return result
    }
    
    func getPlaceMark(forLocation location: CLLocation, completion: @escaping(CLPlacemark?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            completion(placemark, nil)
        }
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion, config: LocationResultsViewConfig) {
        
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error: \(error)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            switch config {
                case .ride:
                    self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
                case .saveLocation(let viewModel):
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    let savedLocation = SavedLocation(title: localSearch.title,
                                                      address: localSearch.subtitle,
                                                      coordinates: GeoPoint(latitude: coordinate.latitude,
                                                                            longitude: coordinate.longitude))
                    guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
                    
                    Firestore.firestore().collection("users").document(uid).updateData([
                        viewModel.databaseKey: encodedLocation
                    ])
            }
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.title)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0 }
        guard let userCoordinate = self.userLocation else { return 0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        let tripDistance = userLocation.distance(from: destination)
        
        return type.computePrice(for: tripDistance)
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping(MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to get directions with error \(error.localizedDescription)")
            }
            
            guard let route = response?.routes.first else { return }
            self.configurePickUpAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickUpAndDropOffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension HomeViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
