//
//  Survey+CoreDataClass.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 23/07/24.
//
//

import Foundation
import CoreData

@objc(Survey)
public class Survey: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, categories
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.categories = try container.decode(Set<Category>.self, forKey: .categories) as NSSet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(categories as! Set<Category>, forKey: .categories)

      }
}
