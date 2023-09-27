//
//  UIViewController+PresentModal.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 26/09/23.
//

import Foundation

import UIKit

extension UIViewController {
    func presentModal(viewController: UIViewController) {
        // Crie uma instância da view controller modal
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // Defina a apresentação modal
        viewController.modalPresentationStyle = .formSheet // ou .formSheet, dependendo da aparência desejada
        
        // Apresente a modal
        present(navigationController, animated: true, completion: nil)
    }
}
