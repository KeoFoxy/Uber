//
//  SettingsView.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            List {
                Section {
                        // User Info Header
                    UserInfoHeader(avatarImageName: "avatar-preview",
                                   userFullname: "user.fullname",
                                   userEmail: "user.email",
                                   isChevronDisplayed: true)
                    .padding(8)
                }
                
                Section("Favourites") {
                    CategoryCellView(title: "Home", subtitle: "Add Home", imageName: "house.circle.fill", fontWeight: .semibold, isChevronDisplayed: true)
                    
                    CategoryCellView(title: "Work", subtitle: "Add Work", imageName: "archivebox.circle.fill", fontWeight: .semibold, isChevronDisplayed: true)
                }
                
                Section("Settings") {
                    CategoryCellView(title: "Notifications", imageName: "bell.circle.fill", imageColor: Color(.systemPurple))
                    
                    CategoryCellView(title: "Payment Methods", imageName: "creditcard.circle.fill", imageColor: Color(.systemOrange))
                }
                
                Section("Account") {
                    CategoryCellView(title: "Make Money Driving", imageName: "dollarsign.circle.fill", imageColor: Color(.systemGreen))
                    CategoryCellView(title: "Sign Out", imageName: "arrow.left.circle.fill", imageColor: Color(.systemRed))
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
            SettingsView()
        }
    }
}
