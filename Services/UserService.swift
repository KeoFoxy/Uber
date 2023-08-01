//
//  UserService.swift
//  Uber
//
//  Created by Alexander Sorokin on 01.08.2023.
//

import Firebase

class UserService: ObservableObject {
    static let shared = UserService()
    @Published var user: User?
    
    init(user: User? = nil) {
        print("DEBUG: Did init user service")
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            print("DEBUG: Did fetch user from firestore")
            guard let snapshot = snapshot else { return }
            guard let user = try? snapshot.data(as: User.self) else { return }
            self.user = user
        }
    }
}
