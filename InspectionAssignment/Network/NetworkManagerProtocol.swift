//
//  NetworkManagerProtocol.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation

protocol NetworkManaging {
    func fetchData<T: Codable>(from url: String) async throws -> T
    func postData<T: Codable>(requestData: T, url: String) async throws -> Bool
}
