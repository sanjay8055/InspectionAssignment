//
//  Inspection.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import Foundation

struct Inspection: Codable {
    let inspection: InspectionDetail?
}

struct InspectionDetail: Codable {
    let id: Int?
    let inspectionType: InspectionType?
    let area: Area?
    var survey: Surveys?
}

struct AnswerChoice: Codable {
    let id: Int?
    let name: String?
    let score: Double?
}

struct Question: Codable {
    let id: Int?
    let name: String?
    let answerChoices: [AnswerChoice]
    var selectedAnswerChoiceId: Int?
}

struct Surveys: Codable {
    let id: Int?
    var categories: [Category]?
}
