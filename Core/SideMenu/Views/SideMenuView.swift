//
//  SideMenuView.swift
//  Uber
//
//  Created by Alexander Sorokin on 29.07.2023.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(spacing: 40) {
            // MARK: Header View
            VStack(alignment: .leading, spacing: 32) {
                /// User Info
                HStack {
                    Image("avatar-preview")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 128, height: 128)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Alice Schuberg")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Text("test@email.com")
                            .font(.system(size: 14))
                            .accentColor(.black)
                            .opacity(0.77)
                    }
                }
                
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
                    SideMenuOptionView(viewModel: option)
                        .padding()
                }
            }
            
            Spacer()
        }
        .padding(.top, 32)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
