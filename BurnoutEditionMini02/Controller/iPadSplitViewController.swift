//
//  iPadSplitViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 11/10/23.
//

import UIKit

class iPadSplitViewController: UISplitViewController, SideBarMenuDelegate {
   
    
    // MARK: - Variáveis
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [SideBarMenuVC(), navHome]
        
        if let sideBar = viewControllers.first as? SideBarMenuVC {
            sideBar.delegate = self
        }
        
    }
    
    func didSelectMenuItem(_ menuItem: String) {
        
        switch menuItem {
        case "achievements".localized:
            self.viewControllers[1] = achievementsVC
        case "reflections".localized:
            self.viewControllers[1] = reflectionVC
        //case "settings".localized:
        //    self.viewControllers[1] = settingsVC
        default:
            self.viewControllers[1] = goalsVC
        }
        
    }

}
