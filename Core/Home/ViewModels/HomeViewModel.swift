//
//  HomeViewModel.swift
//  Uber
//
//  Created by Alexander Sorokin on 31.07.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class HomeViewModel: ObservableObject {
    
    @Published var drivers = [User]()
    
    init() {
        fetchDrivers()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccoutnType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let drivers = documents.compactMap({ try? $0.data(as: User.self) })
                self.drivers = drivers
            }
    }
}
