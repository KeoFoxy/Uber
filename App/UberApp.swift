//
//  UberApp.swift
//  Uber
//
//  Created by Alexander Sorokin on 17.07.2023.
//

import SwiftUI

@main
struct UberApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .statusBarStyle
        }
    }
}
