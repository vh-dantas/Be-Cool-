//
//  CreateGoalVCStore.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 02/10/23.
//

import UIKit

final class CreateGoalVCStore {
    static let shared = CreateGoalVCStore()
    
    //garante que quando a view sair de cena ela não vai ficar em memória
    weak var newGoalModalViewController: NewGoalModalViewController?
    weak var newSubGoalModalViewController: NewSubgoalsModalViewController?
    weak var subgoalLevelViewController: NewSubgoalLevelViewController?
    weak var newWellnessSubgoalsModalViewController: NewWellnessSubgoalsModalViewController?
}
