//
//  AuthViewModel.swift
//  QCoordinator
//
//  Created by Quang on 28/10/25.
//


import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authService = AuthService.shared
    
    init() {
        checkAuthentication()
    }
    
    func checkAuthentication() {
        isAuthenticated = authService.isAuthenticated
        if isAuthenticated {
            loadProfile()
        }
    }
    
    func register(email: String, password: String, name: String) {
        isLoading = true
        errorMessage = nil
        
        authService.register(email: email, password: password, name: name) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let response):
                    self?.currentUser = response.user
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func login(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let response):
                    self?.currentUser = response.user
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadProfile() {
        isLoading = true
        
        authService.getProfile { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let user):
                    self?.currentUser = user
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    if error.localizedDescription.contains("401") {
                        self?.logout()
                    }
                }
            }
        }
    }
    
    func updateProfile(name: String) {
        isLoading = true
        errorMessage = nil
        
        authService.updateProfile(name: name) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let user):
                    self?.currentUser = user
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func logout() {
        authService.logout()
        currentUser = nil
        isAuthenticated = false
    }
}