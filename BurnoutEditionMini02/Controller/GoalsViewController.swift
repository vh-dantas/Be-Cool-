//
//  GoalsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit
import CoreData

// Implementa o protocolo NewGoalModalDelegate
class GoalsViewController: UIViewController, NewGoalModalDelegate, NewSubGoalModalDelegate {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let goalsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical // Define a orientação da stack view como vertical
        stackView.alignment = .leading // Alinha os itens à esquerda
        stackView.distribution = .equalSpacing // Distribui os itens igualmente
        stackView.spacing = 8 // Define o espaçamento
        return stackView
    }()
    
    // Table View
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        // tirar as linhas de separacao
        tableView.separatorStyle = .none
        // ajusta a ditencia entre as celulas
        // tableView.separatorInset = .init(top: 80, left: 100, bottom: 40, right: 50)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //CoreData and TableView
    private var subItems:[SubGoal] = []
    
    // MARK: -- Carrega a view
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  navigationItem.title = "goals".localized
        // O Titulo é a ultima meta adicionada - a meta atual
        navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
        view.backgroundColor = .white // Define a cor de fundo da view como branco
        
        view.addSubview(scrollView)
        scrollView.addSubview(goalsStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        goalsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            goalsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            goalsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            goalsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            goalsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            goalsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
     
        constraintsTableView()
        // Recarregar a array e o titulo
       // addedGoal("Vazia")
        addedSubGoal("Vazia")
        fetchSubGoalsArray()
        // MARK: -- Botões de navegação
        let openModalBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNewGoal))
        navigationItem.rightBarButtonItem = openModalBtn
        
        let openSettingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.leftBarButtonItem = openSettingsButton
    }
    
    
    @objc func createNewGoal() {
        // Certifique-se de criar sua nova view desejada
        let nextScreen = NewGoalModalViewController(homeGoal: self)
        
        nextScreen.delegate = self // Define o delegate
        
        //navegação de telas
        if let navigationController = self.navigationController {
            nextScreen.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(nextScreen, animated: true)
        }
    }
    
    @objc func openSettings() {
        let settingsModalViewController = SettingsModalViewController()
        presentModal(viewController: settingsModalViewController)
    }
    
    func addedGoal(_ goal: String) {
        subItems = []
        DispatchQueue.main.async {
            self.title = DataAcessObject.shared.fetchGoal().first?.title
            self.tableView.reloadData()
        }

 
//        DispatchQueue.main.async {
//            self.navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
//        }
//       // navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
//        if let atualGoal = DataAcessObject.shared.fetchGoal().first {
//            let subGoals = DataAcessObject.shared.fetchSubGoals(goal: atualGoal)
//            for subGoal in subGoals {
//                let goalCheckItem = UIStackView()
//                goalCheckItem.axis = .horizontal // Define a orientação da stack view como horizontal
//                goalCheckItem.spacing = 8 // Define o espaçamento entre os itens
//
//                // Cria o checkmark clicável
//                let checkmarkButton = UIButton(type: .system)
//                checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
//                checkmarkButton.addTarget(self, action: #selector(circleButtonTapped(_:)), for: .touchUpInside)
//
//                // Cria o label que é o nome da meta
//                let goalName = UILabel()
//                goalName.text = subGoal.title
//
//                // Adiciona os dois na stack view goalCheckItem
//                goalCheckItem.addArrangedSubview(checkmarkButton)
//                goalCheckItem.addArrangedSubview(goalName)
//                self.goalsStackView.addArrangedSubview(goalCheckItem)
//
//
//            }
//        }
    }
    
    
    func addedSubGoal(_ subgoal: String) {
        fetchSubGoalsArray()
    }
    
    @objc func circleButtonTapped(_ tappedButton: UIButton) {
        if let buttonImage = tappedButton.currentImage {
            if buttonImage == UIImage(systemName: "circle") {
                tappedButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                tappedButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
}

extension GoalsViewController {
    // Função para buscar todas as goals
    func fetchSubGoalsArray() {
        if let goal = DataAcessObject.shared.fetchGoal().first {
            self.subItems = DataAcessObject.shared.fetchSubGoals(goal: goal)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
// MARK: Table View
extension GoalsViewController: UITableViewDataSource{
    
    
    // Retorna o número de sections da list
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // retorna o numero de elementos presentes em cada section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subItems.count
    }
    
    // Retorna as celulas que preenchem as rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cria a celula da UITableView
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        // Pega os elementos presentes na array e passa cada uma para uma row
        cell.textLabel?.text = subItems[indexPath.row].title //"Celula \(indexPath.item)"
        return cell
    }
    
    // Coloca um title para cada section
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return goalSelected?.title ?? "Meta"
//        
//    }
    
    private func constraintsTableView(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


