//
//  LoginViewModel.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    private let loginService: LoginServiceProtocol
    @Published var error: String = ""
    @Published var loginOrSignupSuccess: Bool = false
    
    init(loginService: LoginServiceProtocol = LoginService()) {
        self.loginService = loginService
    }
    
    func login(with email: String, password: String) async {
        do {
            loginOrSignupSuccess = try await loginService.login(requestData: User(email: email, password: password))
        } catch let error {
            self.error = error.localizedDescription
        }
    }
    
    func register(with email: String, password: String) async {
        do {
            loginOrSignupSuccess = try await loginService.registerNewUser(requestData: User(email: email, password: password))
        } catch let error {
            self.error = error.localizedDescription
        }
    }
}
