//
//  CategoryCellView.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import SwiftUI

struct CategoryCellView: View {
    
    // MARK: Parameters
    
    /// Title of the cell
    let title: String
    
    /// Subtitle is an optional parameter,
    /// By default it is an empty `String`
    /// since not all cells use it.
    /// But if the cell uses it, then VStack is used
    /// For the vertical arrangement of the title and subtitle
    var subtitle: String = ""
    
    /// Component accepts systemImage names
    let imageName: String
    
    /// Customization of the category icon color
    /// By default it is `systemBlue`
    var imageColor: Color = Color(.systemBlue)
    
    /// Since the component is designed for maximum flexibility,
    /// You can customize the font weight of the title.
    /// By default it is `regualr`
    /// Cells in favourite category uses `semibold` fonts
    var fontWeight: Font.Weight = .regular
    
    /// Property that adds a chevron
    /// Image next to User's name and email
    /// Used in settings view
    /// To Show Chevron set `isChevronDisplayed` to `true`
    var isChevronDisplayed: Bool = false
    
    // MARK: Body
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(imageColor)
            
            if subtitle.isEmpty {
                Text(title)
                    .font(.system(size: 15, weight: fontWeight))
                    .foregroundColor(Color.theme.primaryTextColor)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: fontWeight))
                        .foregroundColor(Color.theme.primaryTextColor)
                    
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            if isChevronDisplayed {
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .padding(4)
    }
}

struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
//        CategoryCellView(title: "Home", subtitle: "Add home", imageName: "house.circle.fill")
        CategoryCellView(title: "Home", imageName: "house.circle.fill")
    }
}
