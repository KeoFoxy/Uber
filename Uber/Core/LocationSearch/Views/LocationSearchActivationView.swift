//
//  LocationSearchActivationView.swift
//  Uber
//
//  Created by Alexander Sorokin on 18.07.2023.
//

import SwiftUI

struct LocationSearchActivateView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            
            Text("Where to go?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

struct LocationSearchActivateView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivateView()
    }
}
