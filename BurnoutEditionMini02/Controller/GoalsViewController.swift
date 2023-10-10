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
    
    let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 310, height: 25))
    
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
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let label = UILabel()
    let phrases = ["Dedique tempo ao seu bem-estar também", "Continue buscando o equilíbrio.", "Parabéns! Você está em equilíbrio", "Equilibre seu foco e continue brilhando", "Lembre-se das metas e transforme a procrastinação em ação!"]
    
    //CoreData and TableView
    private var subItems:[SubGoal] = []
    
    // MARK: -- Carrega a view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // O Titulo é a ultima meta adicionada - a meta atual
        navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        constraints()
        fetchSubGoalsArray() // Recarregar a array e o titulo
        
        label.text = "oiiii"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 15)
        
        let index = 4
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
        cell.button.tag = indexPath.row

        switch subGoal.type {
            case "work":
            cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
                cell.backgroundColor = UIColor(named: "WorkCellColor")
                cell.button.tintColor = UIColor(named: "CheckMarkColor")
                cell.button.setImage(UIImage(systemName: subGoal.isCompleted ? "checkmark.circle.fill" : "circle"), for: .normal)
            case "personal":
            cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
                cell.backgroundColor = UIColor(named: "WellnessCellColor")
                cell.button.tintColor = UIColor(named: "HeartCheckColor")
                cell.button.setImage(UIImage(systemName: subGoal.isCompleted ? "heart.fill" : "heart"), for: .normal)
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
    
    @objc func buttonTapped(sender: UIButton) {
        let subGoal = subItems[sender.tag]
        let dao = DataAcessObject()
        dao.toggleIsCompleted(subGoal: subGoal)
        checkSubGoalsCompletion()
        tableView.reloadData()
    }
    
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
        view.addSubview(gradientView)
        view.addSubview(label) // Add the label to the view hierarchy
        
        // Rest of your constraints
        view.addSubview(scrollView)
        scrollView.addSubview(goalsStackView)
        view.addSubview(tableView)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        goalsStackView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: safeArea.topAnchor),
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

class CustomTableViewCell: UITableViewCell {
    let customLabel = UILabel()
    let button = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
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
    
}

class GradientView: UIView {
    let workIcon = UIImageView(image: UIImage(systemName: "briefcase.fill"))
    let lifeIcon = UIImageView(image: UIImage(systemName: "heart.fill"))
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        
        workIcon.tintColor = UIColor(named: "ScaleIcon1Color")
        lifeIcon.tintColor = UIColor(named: "ScaleIcon2Color")
        
        let iconSizeHeight: CGFloat = 18
        let iconSizeWidth: CGFloat = 20
        let yPosition = (bounds.height - iconSizeWidth) / 2
        
        workIcon.frame = CGRect(x: 10, y: yPosition, width: iconSizeWidth, height: iconSizeHeight)
        lifeIcon.frame = CGRect(x: bounds.width - iconSizeWidth - 10, y: yPosition, width: iconSizeWidth, height: iconSizeHeight)
        
        addSubview(workIcon)
        addSubview(lifeIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(named: "WorkSideScaleColor")?.cgColor ?? UIColor.cyan, UIColor(named: "WellnessSideScaleColor")?.cgColor ?? UIColor.systemMint]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        layer.addSublayer(gradientLayer)
        layer.cornerRadius = 13
        layer.masksToBounds = true
    }
}
