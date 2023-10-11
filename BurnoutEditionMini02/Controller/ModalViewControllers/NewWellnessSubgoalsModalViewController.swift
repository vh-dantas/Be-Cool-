//
//  NewWellnessSubgoalsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewWellnessSubgoalsModalViewController: UIViewController, AddSubGoalButtonDelegate, SubGoalCellTextDelegate {
    
    let saveButton = UIButton(type: .system)
    
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    //let timeLabel = UIDatePicker()
    
    // Cria célula com texto e botão de +
    var addSubGoalCell: AddSubGoalCell?
    
    //instancia da model subgoal
    var subGoals = [SubGoalStatic]()
    
    // Cria table view
    var tableView: UITableView!
    
    let stackView = UIStackView()
    
    var timeDigits = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    init() {
        // Sempre chamar este super.init
        super.init(nibName: nil, bundle: nil)
        CreateGoalVCStore.shared.newWellnessSubgoalsModalViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Só testando os valores da view anterior
        if let sliderLevels = CreateGoalVCStore.shared.subgoalLevelViewController?.sliderLevels {
            let subGoals = CreateGoalVCStore.shared.newSubGoalModalViewController?.subGoals ?? []
            
            for (index, subGoal) in subGoals.enumerated() {
                if let level = sliderLevels[index] {
                    print("Index: \(index), Task: \(subGoal.title), Saved Level: \(level)")
                }
            }
        }
        
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupLabels()
        setupTimeCard()
        setupSaveButton()
        setUpTableView()
        //setUpTimeLabel()
        
//        func setUpTimeLabel() {
//            // Horário default de entrada
//            let defaultTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())
//            timeLabel.date = defaultTime ?? Date()
//            timeLabel.datePickerMode = .time
//            view.addSubview(timeLabel)
//            timeLabel.translatesAutoresizingMaskIntoConstraints = false
//
//            NSLayoutConstraint.activate([
//                timeLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
//                timeLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
//                timeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
//            ])
//        }
        
        func setupLabels() {
            firstLabel.translatesAutoresizingMaskIntoConstraints = false
            secondLabel.translatesAutoresizingMaskIntoConstraints = false

            firstLabel.text = "wellness-subgoal-title".localized
            firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            firstLabel.lineBreakMode = .byWordWrapping
            firstLabel.sizeToFit()
            firstLabel.numberOfLines = 0
            
            secondLabel.text = "wellness-subgoal-text".localized
            secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
            secondLabel.lineBreakMode = .byWordWrapping
            secondLabel.sizeToFit()
            secondLabel.numberOfLines = 0
            
            self.view.addSubview(firstLabel)
            self.view.addSubview(secondLabel)
            
            // Constraints
            NSLayoutConstraint.activate([
                firstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
            
            NSLayoutConstraint.activate([
                secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
                secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        }
        
        
        // MARK: -- TIME CARD
        func setupTimeCard() {
            
            
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            for index in 0..<4 {
                // Cria um retângulo com as dimensões e posição certas
                let rectangle = UIView()
                rectangle.backgroundColor = UIColor(named: "TimeCardColor")
                rectangle.layer.cornerRadius = 5
                rectangle.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    rectangle.widthAnchor.constraint(equalToConstant: 55),
                    rectangle.heightAnchor.constraint(equalToConstant: 70)
                ])
                
                let timeDigit = timeDigits[index]
                // Adiciona os dígitos no cartão, um por vez
                timeDigit.textAlignment = .center
                timeDigit.font = UIFont.systemFont(ofSize: 40)
                timeDigit.translatesAutoresizingMaskIntoConstraints = false
                
                rectangle.addSubview(timeDigit)
                NSLayoutConstraint.activate([
                    timeDigit.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor),
                    timeDigit.centerYAnchor.constraint(equalTo: rectangle.centerYAnchor)
                ])
                
                stackView.addArrangedSubview(rectangle)
                                
                // Adiciona o separador (:) entre o segundo e o terceiro cartão
                if index == 1 {
                    let separator = UILabel()
                    separator.text = ":"
                    separator.font = UIFont.systemFont(ofSize: 40)
                    separator.textAlignment = .center
                    stackView.addArrangedSubview(separator)
                }
            }
            
            let (hours, minutes) = Calculator.shared.calculateResult()
            renderTimeDigits(hours: hours, minutes: minutes)
            
            self.view.addSubview(stackView)
            
            // Constraints
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 40),
            ])
        }
        
        func setupSaveButton() {
            saveButton.isUserInteractionEnabled = true
            saveButton.setTitle("save-goals-btn".localized, for: .normal)
            saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            saveButton.backgroundColor = UIColor(red: 0.95, green: 0.43, blue: 0.26, alpha: 1)
            saveButton.setTitleColor(UIColor.white, for: .normal)
            saveButton.layer.cornerRadius = 25
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            saveButton.titleLabel?.sizeToFit()
            let titleWidth = saveButton.titleLabel?.frame.width ?? 0
            let buttonWidth = titleWidth + 40
            NSLayoutConstraint.activate([
                saveButton.widthAnchor.constraint(equalToConstant: buttonWidth),
                saveButton.heightAnchor.constraint(equalToConstant: 50)
            ])

            self.view.addSubview(saveButton)

            NSLayoutConstraint.activate([
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            ])
            
            saveButton.addTarget(self, action: #selector(createGoal), for: .touchUpInside)

        }
    }
    
    func renderTimeDigits(hours: Int, minutes: Int) {
        // transforma o resultado em uma string e separa cada dígito com um .map
        let digits = String(format: "%02d%02d", hours, minutes).map { String($0) }
        
        for index in 0..<digits.count {
            timeDigits[index].text = digits[index]
        }
    }
    
    @objc func createGoal() {
        // Verifique se o valor de timeDigits é "00:00"
        let time = timeDigits.map { label in
            return label.text ?? ""
        }.joined()
        if time == "0000" {
            // se a subgoal estiver vazia a celula eh excluída
            subGoals.enumerated().forEach { index, subGoal in
                if subGoal.title.isEmpty == true {
                    subGoals.remove(at: index)
                }
            }
            tableView.reloadData()
            
            // Cria a navegação de pop para a home
            navigationController?.popToRootViewController(animated: true)
        } else {
            // Mostrar um alerta ao usuário ou tomar outra ação apropriada
            let alertController = UIAlertController(title: "Aviso", message: "O valor do tempo deve ser 00:00 antes de continuar.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            present(alertController, animated: true, completion: nil)
        }

        tableView.reloadData()
        
        //core data
        guard let goal = CreateGoalVCStore.shared.newGoalModalViewController?.goal, let subGoals = CreateGoalVCStore.shared.newSubGoalModalViewController?.subGoals, let subGoalsWellness = CreateGoalVCStore.shared.newWellnessSubgoalsModalViewController?.subGoals else {
            return
        }
        
        //meta
        let newGoal = DataAcessObject.shared.createGoal(title: goal.title)
        //submeta
        subGoals.forEach { subGoal in
            DataAcessObject.shared.createSubGoal(title: subGoal.title, type: subGoal.type, level: subGoal.level, goal: newGoal, date: nil)
        }
        //submeta wellness
        subGoalsWellness.forEach { subGoalWellness in
            guard let date = subGoalWellness.date else { return }
            DataAcessObject.shared.createSubGoal(title: subGoalWellness.title, type: subGoalWellness.type, level: nil, goal: newGoal, date: date)
        }
        
        // Cria a navegação de pop para a home
        navigationController?.popToRootViewController(animated: true)

    }

    
//MARK: --meu
    
    func setUpTableView() {
        // Inicializa a table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddSubGoalCell.self, forCellReuseIdentifier: "addSubGoalCell")
        tableView.register(SubGoalCellText.self, forCellReuseIdentifier: "subGoalCellText")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        // Constraints
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -40),
        ])
    }
    
    ///função que adiciona subgoal ao array static
    func addSubGoalButtonTouched() {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        
        components.hour = 0
        components.minute = 0
        
        let startDate = calendar.date(from: components)
        
        subGoals.append(SubGoalStatic(id: UUID(), title: "", level: .easy, type: .personal, date: startDate))
        toggleAddSubGoalButton()
        tableView.reloadData()
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
    
    func subGoalDateDidChange(_ subGoal: SubGoalStatic, date: Date) {
        var dates = [Date]()
        for s in subGoals {
            if s === subGoal {
                dates.append(date)
            } else if let sDate = s.date {
                dates.append(sDate)
            }
        }
        // pega o valor da classe calculadora
        let (hours, minutes) = Calculator.shared.calculateRemainingTime(wellnessDates: dates)
        if hours >= 0 && minutes >= 0 {
            subGoal.date = date
            renderTimeDigits(hours: hours, minutes: minutes)
        } else {
            // Opcional: Mostrar alerta
            tableView.reloadData()
        }
    }
}

extension NewWellnessSubgoalsModalViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.label.text = "Atividades de Bem-Estar"
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            //se for a primeira e ultima seta as corners embaixo também
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
            if let date = subGoal.date {
                cell.datePicker.date = date
            }
            cell.textField.text = subGoal.title
            cell.subGoal = subGoal
            cell.delegate = self
            cell.type = .date
            cell.selectionStyle = .none // remove a seleção cinza da célula
     
            //corners arrendodadas
            cell.layer.maskedCorners = []
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.backgroundColor = UIColor(named: "SubGoalCellColor")
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.clipsToBounds = true
            }
            return cell
        }
    }
}

