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
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccoutnType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let drivers = documents.compactMap({ try? $0.data(as: User.self) })
                self.drivers = drivers
            }
    }
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
                guard let user = user else { return }
                guard user.accountType == .passenger else { return }
                self.fetchDrivers()
            }
            .store(in: &cancellable)
    }
}

// MARK: - Passenger API

extension HomeViewModel {
    func requestTrip() {
        guard let driver = drivers.first else { return }
        guard let currentUser = currentUser else { return }
        guard let dropoffLocation = selectedUberLocation else { return }
        let dropoffGeoPoint = GeoPoint(latitude: dropoffLocation.coordinate.latitude, longitude: dropoffLocation.coordinate.longitude)
        let userLocation = CLLocation(latitude: currentUser.coordinates.latitude, longitude: currentUser.coordinates.longitude)
        
        getPlaceMark(forLocation: userLocation) { placemark, error in
            guard let placemark = placemark else { return }
            
            let trip = Trip(id: NSUUID().uuidString,
                            passengerUid: currentUser.uid,
                            driverUid: driver.uid,
                            passengerName: currentUser.fullname,
                            driverName: driver.fullname,
                            passengerLocation: currentUser.coordinates,
                            driverLocation: driver.coordinates,
                            pickupLocationName: placemark.name ?? "Current location",
                            dropoffLocationName: dropoffLocation.title,
                            pickupLocationAddress: "Pick up address",
                            dropoffLocationAddress: "123 Main Street",
                            pickupLocation: currentUser.coordinates,
                            dropoffLocation: dropoffGeoPoint,
                            tripCost: 50,
                            tripDistance: 3.6,
                            tripDuration: 20
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
    
}

// MARK: - Location Search Helpers

extension HomeViewModel {
    
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
