//
//  NewSubgoalsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewSubgoalsModalViewController: UIViewController {
    
    // Cria um UILabel
    let label = UILabel()
    // Cria um UITextField
    let textField = UITextField()
    // Cria o botao de adicionar a meta
    let addButton = UIButton(type: .system)
    
    let stackView = UIStackView()
    
    // Dependency Injection (injeção de dependências)
    let goals: [Goal]
    
    //instancia da model subgoal
    var subgoals = [SubGoal]()
    
    
    init(goals: [Goal]) {
        self.goals = goals
        // Sempre chamar este super.init
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = .white
        
        // Configura propriedades do UILabel
        label.text = "Adicione aqui sua subgoal"
        
        // Configura propriedades do UITextField
        textField.placeholder = "Digite algo aqui"
        textField.borderStyle = .roundedRect
        
        //Configura propriedades do UIButton
        addButton.setTitle("Adicionar", for: .normal)
        addButton.addTarget(self, action: #selector(addSubTask), for: .touchUpInside)
        
        //Configura propriedades da StackView
        stackView.axis = .vertical //axis = eixo
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false //para usar as constraints
        
        //Sempre que for criar constraints tem que adicionar antes a subview
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        //adiciona como filhas da stack view
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(addButton)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 52),
            addButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    //função que adiciona subgoal
    @objc func addSubTask() {
        if let subGoalText = textField.text, !subGoalText.isEmpty {
            
            let subgoal = SubGoal(id: UUID(), title: subGoalText, time: Date(), type: .work)
            subgoals.append(subgoal)
            textField.text = ""
            
            // cria a navegacao de push entre as modais
            let NewWellnessSubgoalsModalViewController = NewWellnessSubgoalsModalViewController()
            navigationController?.pushViewController(NewWellnessSubgoalsModalViewController, animated: true)
        }
    }
}

