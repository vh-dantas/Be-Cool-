//
//  NewGoalModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewGoalModalViewController: UIViewController {
    
    // Cria um UILabel
    let label = UILabel()
    // Cria um UITextField
    let textField = UITextField()
    // Cria o botao de adicionar a meta
    var addButton = UIButton()
    
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura propriedades do UILabel
        label.text = "Adicione aqui sua goal"
        label.frame = CGRect(x: 50, y: 50, width: 200, height: 30) // Modifiquei o valor de y para evitar sobreposição
        
        // Configura propriedades do UITextField
        textField.placeholder = "Digite algo aqui"
        textField.borderStyle = .roundedRect
        
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = .white
        
        // Adicione a view da tela
        view.addSubview(label)
        view.addSubview(textField)
        
        // Configure as restrições (autolayout) para o campo de texto
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16), // Mudei o topo do textField para abaixo do label
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Configurar o botão para adicionar tarefas
        addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: view.bounds.width - 80, y: view.bounds.height - 100, width: 60, height: 40)
        addButton.setTitle("Adicionar", for: .normal)
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        view.addSubview(addButton)
        
    }
    
    @objc func addTask() {
        if let taskText = textField.text, !taskText.isEmpty {
            let goal = Goal(id: UUID(), title: taskText)
            goals.append(goal)
            textField.text = ""
            //tableView.reloadData()
        }
    }
}




