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
        
        // Crie um botão
        let button = UIButton(type: .system)
        
        // Defina o título do botão
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        
        // Defina a posição e o tamanho do botão
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        
        // Adiciona uma animação para ser executada quando o botão é tocado
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Adiciona o botão à view da tela
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        // Crie uma instância da view controller modal
        let newGoalModalViewController = NewGoalModalViewController() // Substitua com o nome da sua classe ModalViewController
        
        // Defina a apresentação modal
        newGoalModalViewController.modalPresentationStyle = .formSheet // ou .formSheet, dependendo da aparência desejada
        
        // Apresente a modal
        self.present(newGoalModalViewController, animated: true, completion: nil)
    }
}
        
