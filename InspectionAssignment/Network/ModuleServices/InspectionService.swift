//
//  InspectionNetworkManager.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation

protocol InspectionServiceProtocol {
    func startInspections() async throws -> Inspection
    func submitInspection(inspection: Inspection) async throws -> Bool
}

class InspectionService: InspectionServiceProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func startInspections() async throws -> Inspection {
       return try await networkManager.fetchData(from: UrlPath.startInspectionPath)
    }
    
    func submitInspection(inspection: Inspection) async throws -> Bool {
        return try await networkManager.postData(requestData: inspection, url: UrlPath.submitInspectionPath)
    }
    
}
