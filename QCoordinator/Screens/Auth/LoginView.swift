//
//  AuthView.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }

                Button(action: {
                    authViewModel.login(email: email, password: password)
                }) {
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(
                                CircularProgressViewStyle(tint: .white)
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
        }
    }
}
