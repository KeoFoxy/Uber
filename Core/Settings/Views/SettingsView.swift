//
//  SettingsView.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                        // User Info Header
                    UserInfoHeader(avatarImageName: "avatar-preview",
                                   userFullname: user.fullname,
                                   userEmail: user.email,
                                   isChevronDisplayed: true)
                    .padding(8)
                }
                
                Section("Favorites") {
                    ForEach(SavedLocationViewModel.allCases) { location in
                        NavigationLink {
                            SavedLocationSearchView(config: location)
                        } label: {
                            CategoryCellView(title: location.title, subtitle: location.subtitle, imageName: location.imageName, fontWeight: .semibold)
                        }
                    }
                }
                
                Section("Settings") {
                    CategoryCellView(title: "Notifications", imageName: "bell.circle.fill", imageColor: Color(.systemPurple))
                    
                    CategoryCellView(title: "Payment Methods", imageName: "creditcard.circle.fill", imageColor: Color(.systemOrange))
                }
                
                Section("Account") {
                    CategoryCellView(title: "Make Money Driving", imageName: "dollarsign.circle.fill", imageColor: Color(.systemGreen))
                    CategoryCellView(title: "Sign Out", imageName: "arrow.left.circle.fill", imageColor: Color(.systemRed))
                        .onTapGesture {
                            viewModel.signOut()
                        }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(user: User(fullname: "Violet",
                                    email: "vio",
                                    uid: "1241241"))
        }
    }
}
