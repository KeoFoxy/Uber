//
//  SideMenuView.swift
//  Uber
//
//  Created by Alexander Sorokin on 29.07.2023.
//

import SwiftUI

struct SideMenuView: View {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
            VStack(spacing: 40) {
                // MARK: Header View
                VStack(alignment: .leading, spacing: 32) {
                    /// User Info
                    // TODO: Receive profile from database
                    //       Also add an option to upload photo
                    //       From photos
                    
                    UserInfoHeader(avatarImageName: "avatar-preview",
                                   userFullname: user.fullname,
                                   userEmail: user.email)
                    
                    /// Become a driver
                    
                    VStack(alignment: .leading,spacing: 16) {
                        Text("Do more with your account")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "dollarsign.square")
                                .font(.title)
                                .imageScale(.medium)
                            
                            Text("Make Money Driving")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(6)
                        }
                    }
                    
                    Rectangle()
                        .frame(width: 296, height: 0.75)
                        .opacity(0.7)
                        .foregroundColor(Color(.separator))
                        .shadow(color: .black.opacity(0.7), radius: 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                
                // MARK: Options List
                VStack {
                    ForEach(SideMenuOptionViewModel.allCases) { option in
                        NavigationLink(value: option) {
                            SideMenuOptionView(viewModel: option)
                                .padding()
                        }
                    }
                }
                .navigationDestination(for: SideMenuOptionViewModel.self) {
                    viewModel in
                    switch viewModel {
                        case .trips:
                            Text("Trips")
                        case .wallet:
                            Text("break")
                        case .settings:
                            SettingsView(user: user)
                        case .messages:
                            Text("Messages")
                    }
                }
                
                Spacer()
            }
            .padding(.top, 32)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SideMenuView(user: User(fullname: "Violet",
                                    email: "vio",
                                    uid: "1241241"))
        }
    }
}
