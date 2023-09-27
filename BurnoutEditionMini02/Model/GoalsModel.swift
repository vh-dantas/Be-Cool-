//
//  GoalsModel.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 21/09/23.
//

import Foundation

class Goal {
    var id: Int
    var title: String
    var completed: Bool
    
    init(id: Int, title: String, completed: Bool) {
        self.id = id
        self.title = title
        self.completed = false
    }
}

