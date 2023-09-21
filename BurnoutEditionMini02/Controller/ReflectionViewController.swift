//
//  ReflectionViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class ReflectionViewController: UIViewController {

    let reflectionView = ReflectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instância da view
        view.addSubview(reflectionView)
        reflectionView.setup()
    }

}
