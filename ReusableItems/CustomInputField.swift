//
//  CustomInputField.swift
//  Uber
//
//  Created by Alexander Sorokin on 28.07.2023.
//

import SwiftUI

/// Custom Text Field
/// That is used in Login View and Register View


struct CustomInputField: View {
    
    /// Binding var that containce input
    /// of text field
    @Binding var text: String
    
    /// Title is shown above the text field
    /// It basicly show that should user type
    /// in the text field
    let title: String
    
    /// Text field placeholder
    let placeholder: String
    
    /// Text color that can be changed
    /// By default it is white
    /// It is used as a foreground color
    /// of title and placeholder
    let textColor: Color = .white
    
    /// Settings for password field
    /// By default it shows typing
    /// In case you wanna use passowrd input
    /// Set `isSecureField` to `true`
    var isSecureField: Bool =  false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title
            Text(title)
                .foregroundColor(textColor)
                .fontWeight(.semibold)
                .font(.footnote)
            
            // Text Field
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .foregroundColor(textColor)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(textColor)
            }
            
            // Divider
            Rectangle()
                .foregroundColor(Color(.init(white: 1, alpha: 0.3)))
                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(text: .constant(""), title: "Email", placeholder: "aaa.com")
    }
}
