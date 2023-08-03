//
//  Trip.swift
//  Uber
//
//  Created by Alexander Sorokin on 01.08.2023.
//

import Firebase
import FirebaseFirestoreSwift

enum TripState: Int, Codable {
    case requested
    case rejected
    case accepted
}

struct Trip: Identifiable, Codable {
    @DocumentID var tripId: String?
    
    let passengerUid: String
    let driverUid: String
    
    let passengerName: String
    let driverName: String
    
    let passengerLocation: GeoPoint
    let driverLocation: GeoPoint
    
    let pickupLocationName: String
    let dropoffLocationName: String
    
    let pickupLocationAddress: String
    
    let pickupLocation: GeoPoint
    let dropoffLocation: GeoPoint
    
    let tripCost: Double
    var tripDistance: Double = 0
    var tripDuration: Int = 0
    
    var state: TripState
    
    var id: String {
        return tripId ?? ""
    }
}
