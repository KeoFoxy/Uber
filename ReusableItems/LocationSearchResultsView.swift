//
//  LocationSearchResultsView.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import SwiftUI

struct LocationSearchResultView: View {
    @StateObject var viewModel: LocationSearchViewModel
    let config: LocationResultsViewConfig
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.results, id: \.self) { result in
                    LocationSearchResultCell(
                        title: result.title,
                        subtitle: result.subtitle)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            viewModel.selectLocation(result, config: config)
                        }
                    }
                }
            }
        }
    }
}
