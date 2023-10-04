//
//  ContactUsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 02/10/23.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "contact".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white // Define a cor de fundo da view como branco
    }
}
