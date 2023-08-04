//
//  TripAcceptedView.swift
//  Uber
//
//  Created by Alexander Sorokin on 04.08.2023.
//

import SwiftUI

struct TripAcceptedView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // MARK: - Pickup Info View
            VStack {
                HStack {
                    Text("Meet your driver at Apple Campus for you trip to Starbucks")
                        .font(.body)
                        .frame(height: 44)
                        .lineLimit(2)
                        .padding(.trailing)
                    
                    Spacer()
                    
                    VStack {
                        Text("10")
                            .bold()
                        
                        Text("min")
                            .bold()
                    }
                    .frame(width: 56, height: 56)
                    .foregroundColor(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                }
                .padding()
                
                Divider()
            }
            
            // MARK: - Driver Info View
            VStack {
                HStack {
                    Image("avatar-preview")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Alice Schuberg")
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(.systemYellow))
                                .imageScale(.small)
                            
                            Text("4.9")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: - Driver Vehicle Info
                    
                    VStack(alignment: .center) {
                        Image("uber-x")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 64)
                        
                        HStack {
                            Text("BMW 5 -")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                            
                            Text("46GS90")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .frame(width: 160)
                        .padding(.bottom)
                    }
                }
                
                Divider()
            }
            .padding()
            
            Button {
                print("DEBUG: Cancel trip")
            } label: {
                Text("CANCEL TRIP")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.red)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

struct TripAcceptedView_Previews: PreviewProvider {
    static var previews: some View {
        TripAcceptedView()
    }
}
