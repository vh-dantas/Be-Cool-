//
//  GoalsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit
import CoreData

// Implementa o protocolo NewGoalModalDelegate
class GoalsViewController: UIViewController, UITableViewDataSource, NewGoalModalDelegate, NewSubGoalModalDelegate {

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
    
    // Balança:
    let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 25))
    var imageViewCenterXConstraint: NSLayoutConstraint?
    let imageView = UIImageView(image: UIImage(named: "pinguimScale"))
    let label = UILabel()
    let index = 4
    let phrases = ["Dedique tempo ao seu bem-estar também", "Continue buscando o equilíbrio.", "Parabéns! Você está em equilíbrio", "Equilibre seu foco e continue brilhando", "Lembre-se das metas e transforme a procrastinação em ação!"]
    
    
    // Table View:
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
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
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        
        constraints() // Carrega as constraints da view
        fetchSubGoalsArray() // Recarregar a array e o titulo

        // Texto da balança
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = phrases[index]
        
        
        // MARK: -- Botões de navegação
        let openModalBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNewGoal))
        navigationItem.rightBarButtonItem = openModalBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSubGoalsArray()
        tableView.reloadData()
        navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
        
        
        //if first.iscompleted = true zera a tela
    }
    
    @objc func createNewGoal() {
        let newGoalView = NewGoalModalViewController(homeGoal: self)
        newGoalView.delegate = self // Define o delegate
        
        //navegação de telas
        if let navigationController = self.navigationController {
            newGoalView.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(newGoalView, animated: true)
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
    
    // retorna o numero de elementos presentes em cada section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subItems.count
    }
    
    // Retorna as celulas que preenchem as rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
       
        let subGoal = subItems[indexPath.row]
        cell.customLabel.text = subGoal.title
       // if subGoal.type == "work" {
       //     cell.secondLabel.text = "teste"
       // }
        cell.button.tag = indexPath.row
        
        // verifica o tipo de subgoal pra personalizar a célula
        switch subGoal.type {
        case "work":
            cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            cell.button.tintColor = UIColor(named: "CheckMarkColor")
            cell.button.setImage(UIImage(systemName: subGoal.isCompleted ? "checkmark.circle.fill" : "circle"), for: .normal)
            cell.backgroundColor = UIColor(named: "WorkCellColor")
        case "personal":
            cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            cell.button.tintColor = UIColor(named: "HeartCheckColor")
            cell.button.setImage(UIImage(systemName: subGoal.isCompleted ? "heart.fill" : "heart"), for: .normal)
            cell.backgroundColor = UIColor(named: "WellnessCellColor")
        default:
            break
        }
        return cell
    }
    
    // função pra lidar com o clique no checkmark (salva no core data)
    @objc func buttonTapped(sender: UIButton) {
        let subGoal = subItems[sender.tag]
        let dao = DataAcessObject()
        dao.toggleIsCompleted(subGoal: subGoal)
        checkSubGoalsCompletion()
        movePenguin(for: subGoal)

        tableView.reloadData()
    }

    func movePenguin(for subGoal: SubGoal) {
        var direction: CGFloat = 0
        if subGoal.type == "personal" {
            direction = subGoal.isCompleted ? 20 : -20
        } else if subGoal.type == "work" {
            direction = subGoal.isCompleted ? -20 : 20
        }
        print("Subgoal type: \(subGoal.type), isCompleted: \(subGoal.isCompleted), direction: \(direction)")

        imageViewCenterXConstraint?.constant += direction

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    // verifica se todas as subgoals foram feitas
    func checkSubGoalsCompletion() {
        if let goal = DataAcessObject.shared.fetchGoal().first {
            let subGoals = DataAcessObject.shared.fetchSubGoals(goal: goal)
            let allSubGoalsCompleted = subGoals.allSatisfy { $0.isCompleted }
            if allSubGoalsCompleted && !goal.isCompleted {
                DataAcessObject.shared.toggleIsCompleted(goal: goal)
                let congratulationsViewController = CongratulationsViewController()
                congratulationsViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(congratulationsViewController, animated: true)
            }
        }
    }
    
    
    private func constraints() {
        imageView.contentMode = .scaleAspectFit

        view.addSubview(gradientView)
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(scrollView)
        
        scrollView.addSubview(goalsStackView)
        view.addSubview(tableView)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        goalsStackView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewCenterXConstraint = imageView.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageViewCenterXConstraint!,
            imageView.bottomAnchor.constraint(equalTo: gradientView.topAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalTo: gradientView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 38),
            
            gradientView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 25),
            
            label.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            scrollView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -8),
            
            scrollView.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 1.0),
            
            goalsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            goalsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            goalsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            goalsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            goalsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}


