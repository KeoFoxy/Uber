//
//  UberLocation.swift
//  Uber
//
//  Created by Alexander Sorokin on 27.07.2023.
//

import CoreLocation

struct UberLocation: Identifiable {
    let id = NSUUID().uuidString
    let title: String
    let coordinate: CLLocationCoordinate2D
}
