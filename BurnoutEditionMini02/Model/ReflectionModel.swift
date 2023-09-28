//
//  ReflectionModel.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import UIKit

class ReflectionModel: CustomStringConvertible {
    var id: UUID
    var reflection: String
    var text: String?
    var draw: UIImage?
    var mood: String
    var date: String
    
    init(id: UUID, reflection: String, text: String?, draw: UIImage?, mood: String, date: String) {
        self.id = id
        self.reflection = reflection
        self.text = text
        self.draw = draw
        self.mood = mood
        self.date = date
    }
    
    var description: String {
        return "ID: \(id)\nReflection: \(reflection)\nText: \(text ?? "")\nMood: \(mood)\nDate: \(date)"
    }
}
