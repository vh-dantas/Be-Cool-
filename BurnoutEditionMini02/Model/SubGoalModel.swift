//
//  SubGoalModel.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 22/09/23.
//

import Foundation

enum SubGoalType {
    case work
    case personal
}

class SubGoalStatic {
    var id: UUID
    var title: String
    var level: Int
    var isCompleted: Bool
    var type: SubGoalType
    
    init(id: UUID, title: String, level: Int, isCompleted: Bool = false, type: SubGoalType) {
        self.id = id
        self.title = title
        self.level = level
        self.isCompleted = isCompleted
        self.type = type
    }
}
