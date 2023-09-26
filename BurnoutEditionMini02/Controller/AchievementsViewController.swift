//
//  AchievementsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class AchievementsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Achievements"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white // Define a cor de fundo da view como branco
    }
}
