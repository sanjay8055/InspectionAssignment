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

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)])
    private var items: FetchedResults<Inspections>
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)])
    private var survey: FetchedResults<Survey>
    
    private func addItem() {
        _ = Inspections(context: viewContext)
        do {
            try viewContext.save()
        } catch let error as NSError{
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func Update(questions: Question) {
        do {
            try viewContext.save()
        } catch let error as NSError{
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
