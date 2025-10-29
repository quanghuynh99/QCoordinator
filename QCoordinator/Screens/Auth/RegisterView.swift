//
//
//  AuthView.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @StateObject var authViewModel = AuthViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPasswordMismatchError = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                    
                    // Name Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Full Name")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        TextField("Enter your name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        SecureField("Enter password (min 6 characters)", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Confirm Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm Password")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        SecureField("Confirm your password", text: $confirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Password Mismatch Error
                    if showPasswordMismatchError {
                        Text("Passwords do not match")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    // Error Message
                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Register Button
                    Button(action: {
                        if password != confirmPassword {
                            showPasswordMismatchError = true
                        } else {
                            showPasswordMismatchError = false
                            authViewModel.register(email: email, password: password, name: name)
                        }
                    }) {
                        if authViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("Register")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .background(Color.blue)
                    .cornerRadius(10)
                    .disabled(authViewModel.isLoading || name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
                    
                    // Login Link
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Login")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onChange(of: authViewModel.isAuthenticated) { isAuth in
            if isAuth {
                dismiss()
            }
        }
    }
}
