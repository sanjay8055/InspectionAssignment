//
//  AnswerChoice+CoreDataProperties.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 23/07/24.
//
//

import Foundation
import CoreData


extension AnswerChoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerChoice> {
        return NSFetchRequest<AnswerChoice>(entityName: "AnswerChoice")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var score: Double
}

extension AnswerChoice : Identifiable {

}
