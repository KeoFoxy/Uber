//
//  AuthViewModel.swift
//  Uber
//
//  Created by Alexander Sorokin on 29.07.2023.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        userSession = Auth.auth().currentUser
    }
}
