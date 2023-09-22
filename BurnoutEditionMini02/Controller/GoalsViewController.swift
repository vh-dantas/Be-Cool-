//
//  GoalsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class GoalsViewController: UIViewController {
    
    let goalsView = GoalsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instância da View
        view.addSubview(goalsView)
        goalsView.setup()
    }

}
