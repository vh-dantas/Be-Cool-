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
    //Cria stack view
    let stackView = UIStackView()
    
    // Dependency Injection (injeção de dependências)
    let goals: [GoalStatic]
    
    //instancia da model subgoal
    var subgoals = [SubGoalStatic]()
    // Cria table view
    
    weak var delegate: NewSubGoalModalDelegate?
    
    var tableView: UITableView!
    
    
    init(goals: [GoalStatic]) {
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
        
        // Inicializa a table view
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                
        // Add constraints here
//                tableView.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//                    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//                ])
            
        
        
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
        stackView.addArrangedSubview(tableView)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 52),
            addButton.heightAnchor.constraint(equalToConstant: 52),
            tableView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    ///função que adiciona subgoal
    @objc func addSubTask() {
        if let subGoalText = textField.text, !subGoalText.isEmpty {
            delegate?.addedSubGoal(subGoalText)
            let subgoal = SubGoalStatic(id: UUID(), title: subGoalText, level: Int(), type: .work)
            subgoals.append(subgoal)
            textField.text = ""
            
            tableView.reloadData()
            
            // cria a navegacao de push entre as modais
//            let NewWellnessSubgoalsModalViewController = NewWellnessSubgoalsModalViewController()
//            navigationController?.pushViewController(NewWellnessSubgoalsModalViewController, animated: true)
            
            
        }
    }
}

// Extend o view controller pra entrar em conformidade com a UITableViewDelegate e UITableViewDataSource
extension NewSubgoalsModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subgoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let subgoal = subgoals[indexPath.row]
        
        cell.textLabel?.text = subgoal.title
        
        return cell
    }

}

protocol NewSubGoalModalDelegate: AnyObject {
    func addedSubGoal(_ subgoal: String)
}


