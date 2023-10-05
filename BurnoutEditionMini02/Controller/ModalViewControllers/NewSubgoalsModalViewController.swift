//
//  NewSubgoalsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewSubgoalsModalViewController: UIViewController, AddSubGoalButtonDelegate, SubGoalCellTextDelegate {
    
    // Cria um UILabel
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    // Cria o botao passar para próxima tela
    let bigButton = UIButton(type: .custom)
    
    //Cria stack view
    let stackView = UIStackView()
    
    var addSubGoalCell: AddSubGoalCell?
    
    //instancia da model subgoal
    var subGoals = [SubGoalStatic]()
    
    weak var delegate: NewSubGoalModalDelegate?
    
    // Cria table view
    var tableView: UITableView!
    
    init() {
        // Sempre chamar este super.init
        super.init(nibName: nil, bundle: nil)
        CreateGoalVCStore.shared.newSubGoalModalViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.layer.backgroundColor = UIColor(red: 0.975, green: 0.985, blue: 1, alpha: 1).cgColor
        setUpFirstLabel()
        setUpSecondLabel()
        setUpTableView()
        setUpStackView()
        setUpButton()
    }
    
    //MARK: -- SetUp Elementos da view
    ///titulo da view
    func setUpFirstLabel() {
        // Configura propriedades do UILabel
        firstLabel.text = "Dividindo para conquistar"
        firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        firstLabel.lineBreakMode = .byWordWrapping
        firstLabel.sizeToFit()
        firstLabel.numberOfLines = 0
    }
    
    ///subtitulo da view
    func setUpSecondLabel() {
        secondLabel.text = "Divida sua meta em tarefas menores"
        secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        secondLabel.lineBreakMode = .byWordWrapping
        secondLabel.sizeToFit()
        secondLabel.numberOfLines = 0
    }
    
    ///tableview
    func setUpTableView() {
        // Inicializa a table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddSubGoalCell.self, forCellReuseIdentifier: "addSubGoalCell")
        tableView.register(SubGoalCellText.self, forCellReuseIdentifier: "subGoalCellText")
        
    }
    
    ///botao azul grande
    func setUpButton() {
        //cria um conteiner para adicionar o botao dentro
        let addButtonContainer = UIView()
        addButtonContainer.isUserInteractionEnabled = true // deixa clicável
        addButtonContainer.translatesAutoresizingMaskIntoConstraints = false  //deixa setar as constraints
        view.addSubview(addButtonContainer)
        
        //customizando o botao de ir pra próxima tela
        let buttonSize: CGFloat = 50
        bigButton.backgroundColor = UIColor(red: 0.95, green: 0.43, blue: 0.26, alpha: 1)
        bigButton.tintColor = .white
        bigButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        bigButton.layer.cornerRadius = buttonSize / 2
        bigButton.translatesAutoresizingMaskIntoConstraints = false
        bigButton.addTarget(self, action: #selector(nextView), for: .touchUpInside)  //ação de quando clica no botão
        addButtonContainer.addSubview(bigButton)
        
        //constraints do botao
        NSLayoutConstraint.activate([
            addButtonContainer.heightAnchor.constraint(equalToConstant: buttonSize + 16),
            addButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bigButton.widthAnchor.constraint(equalToConstant: buttonSize),
            bigButton.heightAnchor.constraint(equalToConstant: buttonSize),
            bigButton.bottomAnchor.constraint(equalTo: addButtonContainer.bottomAnchor, constant: -16),
            bigButton.trailingAnchor.constraint(equalTo: addButtonContainer.trailingAnchor, constant: -16)
        ])
        
        //adiciona acessório ao keyboard
        //bottomLineTextField.inputAccessoryView = addButtonContainer
    }
    
    ///stackView
    func setUpStackView() {
        //Configura propriedades da StackView
        stackView.axis = .vertical //axis = eixo
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false //para usar as constraints
        
        //Sempre que for criar constraints tem que adicionar antes a subview
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //adiciona como filhas da stack view
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(tableView)
    }
    
    //MARK: -- Funcionalidades
    @objc func nextView() {
        // Cria a navegação de push entre as telas
        let newSubgoalLevelViewController = NewSubgoalLevelViewController()
        navigationController?.pushViewController(newSubgoalLevelViewController, animated: true)
        
        //se a subgoal estiver vazia exclui
        subGoals.enumerated().forEach { index, subGoal in
            if subGoal.title.isEmpty == true {
                subGoals.remove(at: index)
            }
        }
        tableView.reloadData()
    }
    
    ///função que adiciona subgoal ao array static
    func addSubGoalButtonTouched() {
        subGoals.append(SubGoalStatic(id: UUID(), title: "", level: .easy, type: .work))
        tableView.reloadData()
        toggleAddSubGoalButton()
    }
    
    ///adiciona a subgoal no return do teclado
    func subGoalTextReturnTouched(_ subGoal: SubGoalStatic) {
        if subGoal.title == "" {
            if let index = subGoals.firstIndex(where: { $0 === subGoal }) {
                subGoals.remove(at: index)
            }
            tableView.reloadData()
        }else{
            addSubGoalButtonTouched()
        }
    }
    
    ///deixa o botao de add submeta opaco
    func toggleAddSubGoalButton() {
        if !subGoals.isEmpty {
            addSubGoalCell?.button.isEnabled = subGoals[subGoals.count - 1].title != ""
            addSubGoalCell?.layoutSubviews()
        }
    }
    
    ///atualiza o nome do subgoal em caso de editar
    func subGoalTextDidChangeText(_ subGoal: SubGoalStatic, text: String) {
        subGoal.title = text
        toggleAddSubGoalButton()
    }
}


extension NewSubgoalsModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    //tem que ser +1 pq é o row da table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subGoals.count + 1
    }
    
    //faz com que os rows editaveis sejam apenas os indexPath.row > 0
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row > 0
    }
    
    //função que apaga submeta da tableview
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // tem que ser -1 pq é do array de subgoals
            subGoals.remove(at: indexPath.row - 1)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //exibe elementos da table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //quando tiver na primeira posição de quantidade de subgoals
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addSubGoalCell", for: indexPath) as? AddSubGoalCell
            addSubGoalCell = cell
            guard let cell else {
                return UITableViewCell()  //vai retornar vazio se não conseguir
            }
            cell.delegate = self
            cell.label.text = "Checklist de tarefas"
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.layer.maskedCorners.insert(.layerMinXMaxYCorner)
                cell.layer.maskedCorners.insert(.layerMaxXMaxYCorner)
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "subGoalCellText", for: indexPath) as? SubGoalCellText else {
                return UITableViewCell()
            }
            
            let subGoal = subGoals[indexPath.row - 1]
            cell.textField.text = subGoal.title
            cell.subGoal = subGoal
            cell.delegate = self
            cell.selectionStyle = .none // remove a seleção cinza da célula
            
            cell.layer.maskedCorners = []
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.backgroundColor = .white
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.clipsToBounds = true
            }
            return cell
        }
    }
}

protocol NewSubGoalModalDelegate: AnyObject {
    func addedSubGoal(_ subgoal: String)
}
