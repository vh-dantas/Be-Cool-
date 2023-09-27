//
//  GoalModel.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 22/09/23.
//

import Foundation

class GoalStatic {
    var id: UUID
    var title: String
    var isCompleted: Bool
    
    init(id: UUID, title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
