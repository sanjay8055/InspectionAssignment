//
//  InspectionService.swift
//  InspectionAssignmentTests
//
//  Created by Sanjay Raskar on 22/07/24.
//


import Foundation

class MockInspectionService: InspectionServiceProtocol {
    var result = false
    
    func startInspections() async throws -> Inspection {
        Inspection(inspection: nil)
    }
    
    func submitInspection(inspection: Inspection) async throws -> Bool {
        return result
    }
    
}
