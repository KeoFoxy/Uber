//
//  Trip.swift
//  Uber
//
//  Created by Alexander Sorokin on 01.08.2023.
//

import Firebase

struct Trip: Identifiable, Codable {
    let id: String
    
    let passengerUid: String
    let driverUid: String
    
    let passengerName: String
    let driverName: String
    
    let passengerLocation: GeoPoint
    let driverLocation: GeoPoint
    
    let pickupLocationName: String
    let dropoffLocationName: String
    
    let pickupLocationAddress: String
    let dropoffLocationAddress: String
    
    let pickupLocation: GeoPoint
    let dropoffLocation: GeoPoint
    
    let tripCost: Double
    let tripDistance: Double
    let tripDuration: Int
}