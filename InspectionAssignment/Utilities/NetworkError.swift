//
//  NetworkError.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case serverError
    case invalidResponse
    case keyNotFound
    case unauthorized
    case badRequest
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return "No internet Connection"
        case .unauthorized:
            return "Invalid email or password"
        case .badRequest:
            return "Bad request"
        case .invalidResponse, .keyNotFound:
            return "Invalid response"
        default:
            return "server error"
        }
    }
}
