//
//  LocationSearchView.swift
//  Uber
//
//  Created by Alexander Sorokin on 18.07.2023.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            // Header view
            HStack {
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color.theme.primaryTextColor)
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(
                            .systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(
                            .systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            // List view
            
            LocationSearchResultView(viewModel: viewModel, config: .ride)
        }
        .background(Color.theme.backgroundColor)
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
            .environmentObject(LocationSearchViewModel())
    }
}
