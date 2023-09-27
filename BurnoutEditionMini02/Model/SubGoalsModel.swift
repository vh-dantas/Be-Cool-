//
//  SubGoalsModel.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 21/09/23.
//

import Foundation

enum GoalType {
    case personal
    case work
}

class SubGoal {
    var id: Int
    var title: String
    var completed: Bool
    var time: Date
    var type: GoalType
    
    init(id: Int, title: String, completed: Bool, time: Date, type: GoalType) {
        self.id = id
        self.title = title
        self.completed = false
        self.time = time
        self.type = type
    }
}
