//
//  NewSubgoalsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewSubgoalsModalViewController: UIViewController {

    // Cria um UILabel
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    // Cria um UITextField
    let textField = UITextField()
    
    // Cria o botao de adicionar a meta
    let addButton = UIButton(type: .system)
    
    //Cria stack view
    let stackView = UIStackView()
    
    // Dependency Injection (injeção de dependências)
    let goals: [Goal]

    //instancia da model subgoal
    var subgoals = [SubGoal]()
    
    weak var delegate: NewSubGoalModalDelegate?
    
    // Cria table view
    var tableView: UITableView!
    
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
        firstLabel.text = "Dividindo para conquistar"
        firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        firstLabel.lineBreakMode = .byWordWrapping
        firstLabel.sizeToFit()
        firstLabel.numberOfLines = 0
        
        secondLabel.text = "Divida sua meta em tarefas menores"
        secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        secondLabel.lineBreakMode = .byWordWrapping
        secondLabel.sizeToFit()
        secondLabel.numberOfLines = 0

        
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
        tableView.register(AddSubGoalCell.self, forCellReuseIdentifier: "addSubGoalCell")
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

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
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(tableView)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 52),
            addButton.heightAnchor.constraint(equalToConstant: 52),
            tableView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        fetchSubGoalsArray()
    }
    ///função que adiciona subgoal
    @objc func addSubTask() {
        if let subGoalText = textField.text, !subGoalText.isEmpty {
            delegate?.addedSubGoal(subGoalText)
            // Verificando de a primeira Goal (a ultima goal criada) é nil
            if let newGoal = DataAcessObject.shared.fetchGoal().first {
                DataAcessObject.shared.createSubGoal(title: subGoalText, type: "", goal: newGoal)
                fetchSubGoalsArray()
                textField.text = ""
                
                tableView.reloadData()
                self.setNeedsStatusBarAppearanceUpdate()
                delegate?.addedSubGoal(subGoalText)
            }
        }
    }
}

// Extend o view controller pra entrar em conformidade com a UITableViewDelegate e UITableViewDataSource
extension NewSubgoalsModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subgoals.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //quando tiver na primeira posição de quantidade de subgoasl
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addSubGoalCell", for: indexPath) as? AddSubGoalCell else {
                return UITableViewCell()  //vai retornar vazio se não conseguir
            }
            cell.label.text = "Checklist de tarefas"
            let buttonSize: CGFloat = 25
            
            cell.button.backgroundColor = .systemBlue
            cell.button.tintColor = .white
            cell.button.setImage(UIImage(systemName: "plus"), for: .normal)
            cell.button.layer.cornerRadius = buttonSize / 2
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let subgoal = subgoals[indexPath.row]
            
            cell.textLabel?.text = subgoal.title
            
            return cell
        }
    }
}

protocol NewSubGoalModalDelegate: AnyObject {
    func addedSubGoal(_ subgoal: String)
}


extension NewSubgoalsModalViewController {
    func fetchSubGoalsArray() {
        if let goal = DataAcessObject.shared.fetchGoal().first {
            self.subgoals = DataAcessObject.shared.fetchSubGoals(goal: goal)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
