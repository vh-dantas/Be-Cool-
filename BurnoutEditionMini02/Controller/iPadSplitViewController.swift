//
//  iPadSplitViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 11/10/23.
//

import UIKit

class iPadSplitViewController: UISplitViewController {
    // MARK: - Variáveis
    var navHome: GoalsViewController!
    var sideBar: SideBarMenuVC!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        sideBar = self.viewControllers[0] as? SideBarMenuVC
//        navHome = (self.viewControllers[1] as! UINavigationController).topViewController as? GoalsViewController
        
        
    }

}
