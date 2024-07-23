//
//  Questions+CoreDataClass.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 23/07/24.
//
//

import Foundation
import CoreData

@objc(Questions)
public class Questions: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, name, selectedAnswerChoiceId, answerChoices
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.selectedAnswerChoiceId = try container.decodeIfPresent(Int16.self, forKey: .selectedAnswerChoiceId) ?? -1
        self.answerChoices = try container.decode(Set<AnswerChoice>.self, forKey: .answerChoices) as NSSet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(selectedAnswerChoiceId, forKey: .selectedAnswerChoiceId)
        try container.encode(answerChoices as! Set<AnswerChoice>, forKey: .answerChoices)
      }
}
