//
//  ReflectionModel.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import Foundation

class ReflectionModel: CustomStringConvertible {
    var id: UUID
    var reflection: String
    var text: String
    var mood: String
    var date: String
    
    init(id: UUID, reflection: String, text: String, mood: String, date: String) {
        self.id = id
        self.reflection = reflection
        self.text = text
        self.mood = mood
        self.date = date
    }
    
    var description: String {
        return "ID: \(id)\nReflection: \(reflection)\nText: \(text)\nMood: \(mood)\nDate: \(date)"
    }
}
