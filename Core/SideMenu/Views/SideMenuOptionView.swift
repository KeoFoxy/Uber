//
//  SideMenuOptionView.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import SwiftUI

struct SideMenuOptionView: View {
    let viewModel: SideMenuOptionViewModel
    
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: viewModel.imageName)
                .font(.title2)
                .imageScale(.medium)
            
            Text(viewModel.title)
                .font(.system(size: 16, weight: .semibold))
            
            Spacer()
        }
        .foregroundColor(Color.theme.primaryTextColor)
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(viewModel: .trips)
    }
}
