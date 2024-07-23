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
    @Published var inspection: Inspections?
    let dataController = DataController.instance
    
    init(inspectionService: InspectionServiceProtocol = InspectionService()) {
        self.inspectionService = inspectionService
    }
    
    func startInspection() async {
        if let result = dataController.fetchInspections(), result.count > 0 {
            inspection = result.first
        } else {
            do {
                let result = try await inspectionService.startInspections()
                inspection = result.inspection
                saveData()
            } catch let error {
                self.error = error.localizedDescription
            }
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
        inspection?.survey?.categoriesArray ?? []
    }
    
    func saveData() {
        dataController.saveData()
    }
    
    func submitInspection() async {
        if let inspection {
           await submitInspection(inspection: Inspection(inspection: inspection))
        }
    }
}
