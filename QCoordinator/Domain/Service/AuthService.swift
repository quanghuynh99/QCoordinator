//
//  AuthService.swift
//  QCoordinator
//
//  Created by Quang on 28/10/25.
//


import Foundation
import Alamofire

class AuthService {
    static let shared = AuthService()
    
    // Thay đổi URL này thành địa chỉ server của bạn
    private let baseURL = "http://localhost:8080/api"
    
    private init() {}
    
    // MARK: - Token Management
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
    
    func removeToken() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
    
    var isAuthenticated: Bool {
        return getToken() != nil
    }
    
    // MARK: - Headers
    
    private func authHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        if let token = getToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    // MARK: - API Methods
    
    func register(email: String, password: String, name: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let url = "\(baseURL)/auth/register"
        let parameters = RegisterRequest(email: email, password: password, name: name)
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: authHeaders())
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    self.saveToken(loginResponse.token)
                    completion(.success(loginResponse))
                case .failure(let error):
                    if let data = response.data,
                       let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(NSError(domain: "", code: response.response?.statusCode ?? 0,
                                                   userInfo: [NSLocalizedDescriptionKey: errorResponse.error])))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let url = "\(baseURL)/auth/login"
        let parameters = LoginRequest(email: email, password: password)
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: authHeaders())
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    self.saveToken(loginResponse.token)
                    completion(.success(loginResponse))
                case .failure(let error):
                    if let data = response.data,
                       let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(NSError(domain: "", code: response.response?.statusCode ?? 0,
                                                   userInfo: [NSLocalizedDescriptionKey: errorResponse.error])))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func getProfile(completion: @escaping (Result<User, Error>) -> Void) {
        let url = "\(baseURL)/profile"
        
        AF.request(url,
                   method: .get,
                   headers: authHeaders())
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    if let data = response.data,
                       let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(NSError(domain: "", code: response.response?.statusCode ?? 0,
                                                   userInfo: [NSLocalizedDescriptionKey: errorResponse.error])))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func updateProfile(name: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = "\(baseURL)/profile"
        let parameters = UpdateProfileRequest(name: name)
        
        AF.request(url,
                   method: .put,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: authHeaders())
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    if let data = response.data,
                       let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(NSError(domain: "", code: response.response?.statusCode ?? 0,
                                                   userInfo: [NSLocalizedDescriptionKey: errorResponse.error])))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func logout() {
        removeToken()
    }
}