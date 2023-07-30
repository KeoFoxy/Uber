//
//  UserInfoHeader.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import SwiftUI

struct UserInfoHeader: View {
    
    let avatarImageName: String
    
    let userFullname: String
    
    let userEmail: String
    
    /// You can customize avatar frame
    /// By default it is 64 by 64
    /// Height and width must be equal
    var avatarWidth: CGFloat = 64
    var avatarHeight: CGFloat = 64
    
    /// Property that adds a chevron
    /// Image next to User's name and email
    /// Used in settings view
    /// To Show Chevron set `isChevronDisplayed` to `true`
    var isChevronDisplayed: Bool = false
    
    
    var body: some View {
        HStack {
            Image(avatarImageName)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: avatarWidth, height: avatarHeight)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(userFullname)
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.leading)
                
                Text(userEmail)
                    .font(.system(size: 14))
                    .accentColor(Color.theme.primaryTextColor)
                    .opacity(0.77)
            }
            
            if isChevronDisplayed {
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct UserInfoHeader_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoHeader(avatarImageName: "avatar-preview",
                       userFullname: "Alice Schuberg",
                       userEmail: "test@gm.com",
                       isChevronDisplayed: true)
    }
}
