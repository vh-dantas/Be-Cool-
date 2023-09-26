//
//  ReflectionModel.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import Foundation

class ReflectionModel {
    var id: UUID
    var title: String
    var reflection: String
    var mood: String
    
    init(id: UUID, title: String, reflection: String, mood: String) {
        self.id = id
        self.title = title
        self.reflection = reflection
        self.mood = mood
    }
}
