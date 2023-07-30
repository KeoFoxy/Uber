//
//  User.swift
//  Uber
//
//  Created by Alexander Sorokin on 29.07.2023.
//

import Firebase

enum AccoutnType: Int, Codable {
    case passenger
    case driver
}

struct User: Codable {
    let fullname: String
    let email: String
    let uid: String
    var coordinates: GeoPoint
    var accountType: AccoutnType
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}
