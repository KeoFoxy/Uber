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
                        workLocation: nil)
}
