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

class SubGoal {
    var id: UUID
    var title: String
    var time: Date
    var isCompleted: Bool
    var type: SubGoalType
    
    init(id: UUID, title: String, time: Date, isCompleted: Bool = false, type: SubGoalType) {
        self.id = id
        self.title = title
        self.time = time
        self.isCompleted = isCompleted
        self.type = type
    }
}
