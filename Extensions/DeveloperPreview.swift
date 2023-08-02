//
//  DeveloperPreview.swift
//  Uber
//
//  Created by Alexander Sorokin on 31.07.2023.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
    
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let mockUser = User(fullname: "Alice Schuberg",
                        email: "alice@gm.com",
                        uid: NSUUID().uuidString,
                        coordinates: GeoPoint(latitude: 37.38, longitude: -122.05),
                        accountType: .passenger,
                        homeLocation: nil,
                        workLocation: nil
    )
    
    let mockTrip = Trip(id: NSUUID().uuidString,
                        passengerUid: NSUUID().uuidString,
                        driverUid: NSUUID().uuidString,
                        passengerName: "Alice Schuberg",
                        driverName: "Violet Evergarden",
                        passengerLocation: .init(latitude: 37.123, longitude: -122.1),
                        driverLocation: .init(latitude: 37.101, longitude: -122.07),
                        pickupLocationName: "Apple campus",
                        dropoffLocationName: "Starbucks",
                        pickupLocationAddress: "123 Main St, Palo Alto CA",
                        dropoffLocationAddress: "321 Alt St, Palo Alto CA",
                        pickupLocation: .init(latitude: 37.037, longitude: -122.15),
                        dropoffLocation: .init(latitude: 37.079, longitude: -122.23),
                        tripCost: 20,
                        tripDistance: 20,
                        tripDuration: 20
    )
}
