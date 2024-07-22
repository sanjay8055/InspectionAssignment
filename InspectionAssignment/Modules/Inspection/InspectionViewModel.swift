//
//  InspectionViewModel.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 21/07/24.
//

import Foundation

@MainActor
class InspectionViewModel: ObservableObject {
    private let inspectionService: InspectionServiceProtocol
    @Published var error: String = ""
    @Published var inspection: InspectionDetail?

    init(inspectionService: InspectionServiceProtocol = InspectionService()) {
        self.inspectionService = inspectionService
    }
    
    func startInspection() async {
        do {
            let result = try await inspectionService.startInspections()
            inspection = result.inspection
        } catch let error {
            self.error = error.localizedDescription
        }
    }
    
    func submitInspection(inspection: Inspection) async {
        do {
            _ = try await inspectionService.submitInspection(inspection: inspection)
        } catch let error {
            self.error = error.localizedDescription
        }
    }
    
    var surveyCategories: [Category] {
        inspection?.survey?.categories ?? []
    }
    
    func saveDraftInspection(categoryIndex: Int, questionIndex: Int, choiceId: Int) {
        if var category = inspection?.survey?.categories?.filter({$0.id == categoryIndex}).first {
           var questions = category.questions
            questions[questionIndex].selectedAnswerChoiceId = choiceId
            category.questions = questions
        }
    }
    
    func submitInspection() async {
        if let inspection {
           await submitInspection(inspection: Inspection(inspection: inspection))
        }
    }
}
