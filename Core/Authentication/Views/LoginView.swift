//
//  LoginView.swift
//  Uber
//
//  Created by Alexander Sorokin on 28.07.2023.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    
                    // Image and title
                    
                    VStack{
                        Image("uber-app-icon")
                            .resizable()
                            .frame(width: 200, height: 200)
                        
                        Text("UBER")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    
                    
                    // Input fields
                    
                    VStack {
                        // Input Field 1

                        CustomInputField(text: $email, title: "Email", placeholder: "example@example.com")
                        
                        CustomInputField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        
                        Button {
                            
                        } label: {
                            Text("Forgot password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // Social sign in view
                    
                    VStack {
                        
                        HStack(spacing: 24) {
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                            
                            Text("Sign in with social")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                        }
                        
                        HStack(spacing: 12) {
                            Button {
                                
                            } label: {
                                Image("gmail")
                            }

                            Button {
                                
                            } label: {
                                Image("insta")
                            }
                            
                            Button {
                                
                            } label: {
                                Image("twitter")
                            }
                            
                            Button {
                                
                            } label: {
                                Image("telegram")
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    // Sign in button
                    
                    Button {
                        viewModel.signIn(withEmail: email, password: password)
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .foregroundColor(.black)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(.white)
                    .cornerRadius(10)

                    
                    // Sign up button
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up")
                                .font(.system(size: 14).weight(.semibold))
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
