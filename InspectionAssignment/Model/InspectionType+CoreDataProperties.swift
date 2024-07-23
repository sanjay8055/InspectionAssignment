//
//  InspectionType+CoreDataProperties.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 23/07/24.
//
//

import Foundation
import CoreData


extension InspectionType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionType> {
        return NSFetchRequest<InspectionType>(entityName: "InspectionType")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var access: String?

}

extension InspectionType : Identifiable {

}
