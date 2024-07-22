//
//  LoginViewModelTests.swift
//  InspectionAssignmentTests
//
//  Created by Sanjay Raskar on 22/07/24.
//

@testable import InspectionAssignment
import XCTest

@MainActor
final class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel!
    var loginService: MockLoginService = MockLoginService()

     override func setUpWithError() throws {
        loginViewModel = LoginViewModel(loginService: loginService)
    }

    override func tearDownWithError() throws {
        loginViewModel = nil
    }

   
    func testLoginSuccess() async throws {
        loginService.result = true
        await loginViewModel.login(with: "test@mail.com", password: "test123")
        XCTAssertTrue(loginViewModel.loginOrSignupSuccess)
    }
    
    func testLoginFailure() async throws {
        loginService.result = false
        await loginViewModel.login(with: "test@mail.com", password: "test123")
        XCTAssertFalse(loginViewModel.loginOrSignupSuccess)
    }
    
    func testSignupSuccess() async throws {
        loginService.result = true
        await loginViewModel.register(with: "test@mail.com", password: "test123")
        XCTAssertTrue(loginViewModel.loginOrSignupSuccess)
    }
    
    func testSignupFailure() async throws {
        loginService.result = false
        await loginViewModel.register(with: "test@mail.com", password: "test123")
        XCTAssertFalse(loginViewModel.loginOrSignupSuccess)
    }

}
