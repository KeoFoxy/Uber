//
//  SideMenuOptionViewModel.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import SwiftUI

enum SideMenuOptionViewModel: Int, CaseIterable, Identifiable {
    case trips
    case wallet
    case settings
    case messages
    
    var id: Int { return rawValue }
    
    var title: String {
        switch self {
            case .trips: return "Your Trips"
            case .wallet: return "Wallet"
            case .settings: return "Settings"
            case .messages: return "Messages"
        }
    }
    
    var imageName: String {
        switch self {
            case .trips: return "list.bullet.rectangle"
            case .wallet: return "creditcard"
            case .settings: return "gear"
            case .messages: return "bubble.left"
        }
    }
}
