//
//  SavedLocation.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import Firebase
import Foundation

struct SavedLocation: Codable {
    let title: String
    let address: String
    let coordinates: GeoPoint
}
