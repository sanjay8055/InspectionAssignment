//
//  Inspections+CoreDataProperties.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 23/07/24.
//
//

import Foundation
import CoreData


extension Inspections {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inspections> {
        return NSFetchRequest<Inspections>(entityName: "Inspections")
    }

    @NSManaged public var id: Int16
    @NSManaged public var status: String?
    @NSManaged public var inspectionType: InspectionType?
    @NSManaged public var survey: Survey?
    @NSManaged public var area: Area?

}

// MARK: Generated accessors for survey
extension Inspections {

    @objc(addSurveyObject:)
    @NSManaged public func addToSurvey(_ value: Survey)

    @objc(removeSurveyObject:)
    @NSManaged public func removeFromSurvey(_ value: Survey)

    @objc(addSurvey:)
    @NSManaged public func addToSurvey(_ values: NSSet)

    @objc(removeSurvey:)
    @NSManaged public func removeFromSurvey(_ values: NSSet)

}

extension Inspections : Identifiable {

}
