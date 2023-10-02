//
//  SubGoalModel.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 22/09/23.
//

import Foundation

enum SubGoalType: String {
    case work
    case personal
}
enum Difficulty {
    case easy
    case medium
    case hard
}

class SubGoalStatic {
    var id: UUID
    var title: String
    var level: Difficulty
    var isCompleted: Bool
    var type: SubGoalType
    
    init(id: UUID, title: String, level: Difficulty, isCompleted: Bool = false, type: SubGoalType) {
        self.id = id
        self.title = title
        self.level = level
        self.isCompleted = isCompleted
        self.type = type
    }
}
