//
//  MockLoginService.swift
//  InspectionAssignmentTests
//
//  Created by Sanjay Raskar on 22/07/24.
//

import Foundation

class MockLoginService: LoginServiceProtocol {
    
    var result = false
    
    func registerNewUser(requestData: User) async throws -> Bool {
        return result
    }
    
    func login(requestData: User) async throws -> Bool {
        return result
    }
    
    
}
