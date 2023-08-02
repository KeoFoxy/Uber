//
//  GeoPoint.swift
//  Uber
//
//  Created by Alexander Sorokin on 02.08.2023.
//

import Firebase
import CoreLocation

extension GeoPoint {
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
