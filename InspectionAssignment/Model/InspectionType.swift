//
//  InspectionType.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation

struct InspectionType: Codable {
    let id: Int?
    let name: String
    let access: String
}

struct Category: Codable {
    let id: Int?
    let name: String?
    var questions: [Question]
}

extension Category: Identifiable, Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }  
}
