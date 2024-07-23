//
//  Persistence.swift
//  test
//
//  Created by Sanjay Raskar on 21/07/24.
//

import CoreData

class DataController: ObservableObject {
    static let instance = DataController()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Inspections")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data!")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error.localizedDescription)")
        }
    }
    
    func fetchInspections() -> [Inspections]? {
        let request = NSFetchRequest<Inspections>(entityName: "Inspections")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        var inspections: [Inspections]?
        do {
            inspections = try context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        return inspections
    }
}

