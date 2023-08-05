//
//  MapViewState.swift
//  Uber
//
//  Created by Alexander Sorokin on 19.07.2023.
//

import Foundation

enum MapViewState {
    case noInput
    case locationSelected
    case searchingForLocation
    case polylineAdded
    case tripRequested
    case tripAccepted
    case tripRejected
    case tripCancelledByPassenger
    case tripCancelledByDriver
}
