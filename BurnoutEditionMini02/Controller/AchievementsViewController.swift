//
//  AchievementsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class AchievementsViewController: UIViewController {

    let achievementsView = AchievementsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instância da view
        view.addSubview(achievementsView)
        achievementsView.setup()
    }
    

}
