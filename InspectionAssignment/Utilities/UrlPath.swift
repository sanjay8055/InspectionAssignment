//
//  UrlPath.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation

struct UrlPath {
    static private let baseUrl = "http://127.0.0.1:5001"
    static private let login = "/api/login"
    static private let register = "/api/register"
    static private let startInspection = "/api/inspections/start"
    static private let submitInspection = "/api/inspections/submit"
    
    static var loginPath: String {
        baseUrl + login
    }
    
    static var registerPath: String {
        baseUrl + register
    }
    
    static var startInspectionPath: String {
        baseUrl + startInspection
    }
    
    static var submitInspectionPath: String {
        baseUrl + submitInspection
    }
}
