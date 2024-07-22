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
        Inspection(inspection: InspectionDetail(id: 1, inspectionType: InspectionType(id: 1, name: "", access: ""), area: nil, survey: Surveys(id: 1, categories: [])))
    }
    
    func submitInspection(inspection: Inspection) async throws -> Bool {
        return result
    }
    
}
