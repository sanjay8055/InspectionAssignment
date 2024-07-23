//
//  Inspections+CoreDataClass.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 23/07/24.
//
//

import Foundation
import CoreData

@objc(Inspections)
public class Inspections: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, status, inspectionType, survey, area
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.inspectionType = try container.decode(InspectionType.self, forKey: .inspectionType)
        self.survey = try container.decode(Survey.self, forKey: .survey)
        self.area = try container.decode(Area.self, forKey: .area)

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encode(inspectionType, forKey: .inspectionType)
        try container.encode(survey, forKey: .survey)
        try container.encode(area, forKey: .area)

      }
}
