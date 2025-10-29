//
//  User.swift
//  QCoordinator
//
//  Created by Quang on 28/10/25.
//


import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct LoginResponse: Codable {
    let token: String
    let user: User
}

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let name: String
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct UpdateProfileRequest: Codable {
    let name: String
}

struct ErrorResponse: Codable {
    let error: String
}