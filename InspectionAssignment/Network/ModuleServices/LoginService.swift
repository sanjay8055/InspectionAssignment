//
//  LoginService.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation

protocol LoginServiceProtocol {
    func registerNewUser(requestData: User) async throws -> Bool
    func login(requestData: User) async throws -> Bool
}

class LoginService: LoginServiceProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func registerNewUser(requestData: User) async throws -> Bool {
        return try await networkManager.postData(requestData: requestData, url: UrlPath.registerPath)
    }

    func login(requestData: User) async throws -> Bool  {
        return try await networkManager.postData(requestData: requestData, url: UrlPath.loginPath)
    }
}
