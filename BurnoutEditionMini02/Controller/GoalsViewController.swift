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
        tableView.allowsSelection = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //CoreData and TableView
    private var subItems:[SubGoal] = []
    
    // MARK: -- Carrega a view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // O Titulo é a ultima meta adicionada - a meta atual
        navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        constraints()
        fetchSubGoalsArray() // Recarregar a array e o titulo
        
        // MARK: -- Botões de navegação
        let openModalBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNewGoal))
        navigationItem.rightBarButtonItem = openModalBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSubGoalsArray()
        tableView.reloadData()
        navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
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
    
    func addedGoal(_ goal: String) {
        subItems = []
        DispatchQueue.main.async {
            self.title = DataAcessObject.shared.fetchGoal().first?.title
            self.tableView.reloadData()
        }
    }
    
    func addedSubGoal(_ subgoal: String) {
        fetchSubGoalsArray()
    }
    
    func fetchSubGoalsArray() { // Função para buscar todas as goals
        if let goal = DataAcessObject.shared.fetchGoal().first {
            self.subItems = DataAcessObject.shared.fetchSubGoals(goal: goal)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: -- Table View
extension GoalsViewController: UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let subGoal = subItems[indexPath.row]
        
        cell.customLabel.text = subGoal.title
        
        switch subGoal.type {
        case "work":
            cell.backgroundColor = UIColor(named: "WorkCellColor")
            cell.button.setImage(UIImage(systemName: "circle"), for: .normal)
            cell.button.tintColor = UIColor(named: "CheckMarkColor")
        case "personal":
            cell.backgroundColor = UIColor(named: "WellnessCellColor")
            cell.button.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.button.tintColor = UIColor(named: "HeartCheckColor")
        default:
            break
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = cell.bounds
        let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 20, height: 10))
        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer
        
        return cell
    }
    
    
    private func constraints(){
        view.addSubview(scrollView)
        scrollView.addSubview(goalsStackView)
        view.addSubview(tableView)
        
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
            goalsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

class CustomTableViewCell: UITableViewCell {
    let customLabel = UILabel()
    let button = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customLabel)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 10),
            customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            customLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            customLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        switch button.currentImage {
        case UIImage(systemName: "circle"):
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            customLabel.textColor = .lightGray
        case UIImage(systemName: "checkmark.circle.fill"):
            button.setImage(UIImage(systemName: "circle"), for: .normal)
        case UIImage(systemName: "heart"):
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        case UIImage(systemName: "heart.fill"):
            button.setImage(UIImage(systemName: "heart"), for: .normal)
        default:
            break
        }
    }

}
