//
//  Questions+CoreDataProperties.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 23/07/24.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var selectedAnswerChoiceId: Int16
    @NSManaged public var answerChoices: NSSet?

    var answerchoicesArray: [AnswerChoice] {
        let set = answerChoices as? Set<AnswerChoice> ?? []
        return set.sorted {
            $0.id < $1.id
        }
    }
}

// MARK: Generated accessors for answerchoices
extension Questions {

    @objc(addAnswerChoicesObject:)
    @NSManaged public func addToAnswerChoices(_ value: AnswerChoice)

    @objc(removeAnswerChoicesObject:)
    @NSManaged public func removeFromAnswerchoices(_ value: AnswerChoice)

    @objc(addAnswerChoices:)
    @NSManaged public func addToAnswerChoices(_ values: NSSet)

    @objc(removeAnswerChoices:)
    @NSManaged public func removeFromAnswerchoices(_ values: NSSet)

}

extension Questions : Identifiable {

}
