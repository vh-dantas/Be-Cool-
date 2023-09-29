//
//  ReflectionModel.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import UIKit

class ReflectionModel: CustomStringConvertible {
    var id: UUID
    var name: String
    var relatedGoal: GoalStatic?
    var randomRefQst: String
    var randomRefAns: String?
    var draw: UIImage?
    var mood: String
    var date: String
    
    init(id: UUID, name: String, relatedGoal: GoalStatic?, randomRefQst: String, randomRefAns: String?, draw: UIImage?, mood: String, date: String) {
        self.id = id
        self.name = name
        self.relatedGoal = relatedGoal
        self.randomRefQst = randomRefQst
        self.randomRefAns = randomRefAns
        self.draw = draw
        self.mood = mood
        self.date = date
    }
    
    var description: String {
        return "ID: \(id)\nName: \(name)\nRelated Goal: \(String(describing: relatedGoal?.title ?? nil))\nRandom Reflection Question: \(randomRefQst)\nRandom Reflection Answer: \(randomRefAns ?? "")\nMood: \(mood)\nDate: \(date)"
    }
}
