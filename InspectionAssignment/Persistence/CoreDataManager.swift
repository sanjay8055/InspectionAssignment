//
//  CoreDataManager.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 22/07/24.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)])
    private var survey: FetchedResults<Survey>
    
    func addSurevy(inspectionSurvey: Surveys, questions: [QuestionAnswer]) {
//        @FetchRequest(
//            entity: Inspections.entity(),
//            sortDescriptors: [
//                NSSortDescriptor(keyPath: \Category.name, ascending: true),
//            ],
//            predicate: NSPredicate(format: "id == %@", 1)
//        )
        guard let survey = fetchInspection(1) else { return }
        
        if survey.count > 0 {
            survey[0].questions = Set(questions) as NSSet
        } else {
            let newSurvey = Survey(context: self.viewContext)
            let questionAnswer = QuestionAnswer(context: self.viewContext)

            //ForEach(inspectionSurvey.categories ?? [], id: \.id) { category in
            if let category = inspectionSurvey.categories?[0] {
                newSurvey.id = Int16(category.id ?? 0)
                newSurvey.name = category.name
                let questions = category.questions.map({questionAnswer.id = $0.id;, questionAnswer.name = $0.name, questionAnswer.selectedAnswerChoiceId = $0.answerChoices, selectedAnswerChoiceId = selectedAnswerChoiceId)})
                newSurvey.questions = questions
            }
           
        }
        
        do {
            try viewContext.save()
        } catch let error as NSError{
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    private func fetchInspection(_ id: Int) -> [Survey]? {
        let fetchRequest = NSFetchRequest<Survey>(entityName: "Survey")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let results = try? viewContext.fetch(fetchRequest)
        return results
    }
    
    func Update(questions: Question) {
        do {
            try viewContext.save()
        } catch let error as NSError{
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
