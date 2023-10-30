//
//  GoalsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit
import CoreData
import TipKit


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
    var index = 3
    let phrases = ["scale-1".localized, "scale-2".localized, "scale-3".localized, "scale-4".localized, "scale-5".localized]
    
    
    // Table View:
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = 70
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let emptyGoalImage: UIImageView = {
       let burnImage = UIImageView()
       burnImage.image = UIImage(named: "EmptyGoalImage")
       burnImage.translatesAutoresizingMaskIntoConstraints = false
       burnImage.contentMode = .scaleAspectFit
       return burnImage
   }()
    
    private let emptyGoalLabel: UILabel = {
       let label = UILabel()
        label.text = "empty-goal".localized
        label.textColor = .lightGray
        label.accessibilityLabel = "empty-goal".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let addTip = CreateGoalTip(id: "addTip")


    //CoreData and TableView
    private var subItems:[SubGoal] = []
    
    
    // MARK: -- Carrega a view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // O Titulo é a ultima meta adicionada - a meta atual
        navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        
        constraints() // Carrega as constraints da view
        fetchSubGoalsArray() // Recarregar a array e o titulo
        updatePhrases()
        
        // Texto da balança
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = phrases[index]
        noCurrentGoal()
        
        // MARK: -- Botões de navegação
        let openModalBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNewGoal))
        openModalBtn.accessibilityLabel = "new-goal-hint".localized
        navigationItem.rightBarButtonItem = openModalBtn
        
        if #available(iOS 17.0, *) {
            Task { @MainActor in
                for await shouldDisplay in addTip.shouldDisplayUpdates {
                    if shouldDisplay {
                        let controller = TipUIPopoverViewController(addTip, sourceItem: openModalBtn)
                        present(controller, animated: true)
                    } else if presentedViewController is TipUIPopoverViewController {
                        dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSubGoalsArray()
        tableView.reloadData()
        navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title
        noCurrentGoal()
        
  
        
        //if first.iscompleted = true zera a tela
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        
    }
    
    // Função para verificar a pessoa precisa criar uma nova meta
    func noCurrentGoal() {
        if DataAcessObject.shared.fetchGoal().first?.isCompleted == true || DataAcessObject.shared.fetchGoal().isEmpty {
            tableView.removeFromSuperview()
            label.text = "level-neutral".localized
            label.accessibilityLabel = "level-neutral".localized
            navigationItem.title = "empty-goal-title".localized
            navigationItem.accessibilityLabel = "empty-goal-title".localized
            view.addSubview(emptyGoalImage)
            view.addSubview(emptyGoalLabel)
            
            NSLayoutConstraint.activate([
                emptyGoalImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                emptyGoalImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
                emptyGoalImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyGoalImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyGoalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                emptyGoalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                emptyGoalLabel.topAnchor.constraint(equalTo: emptyGoalImage.bottomAnchor)
                
            ])
        } else {
            emptyGoalImage.removeFromSuperview()
            emptyGoalLabel.removeFromSuperview()
            view.addSubview(tableView)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            label.text = "scale-3".localized
            label.accessibilityLabel = "scale-3".localized
            navigationItem.title = DataAcessObject.shared.fetchGoal().first?.title

        }
    }
    
    @objc func createNewGoal() {
        let newGoalView = NewGoalModalViewController(homeGoal: self)
        newGoalView.delegate = self // Define o delegate
        
        //navegação de telas
        if let navigationController = self.navigationController {
            Vibration.shared.vibrate2(for: .light)
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
        cell.button.tag = indexPath.row
        
        // verifica o tipo de subgoal pra personalizar a célula
        switch subGoal.type {
        case "work":
            cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            cell.button.tintColor = UIColor(named: "CheckMarkColor")
            cell.button.setImage(UIImage(systemName: subGoal.isCompleted ? "checkmark.circle.fill" : "circle"), for: .normal)
            cell.rectangleView.backgroundColor = UIColor(named: "WorkCellColor")
            cell.button.accessibilityHint = "work-button-hint".localized
        case "personal":
            cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            cell.button.tintColor = UIColor(named: "HeartCheckColor")
            cell.button.setImage(UIImage(systemName: subGoal.isCompleted ? "heart.fill" : "heart"), for: .normal)
            cell.rectangleView.backgroundColor = UIColor(named: "WellnessCellColor")
            cell.button.accessibilityHint = "personal-button-hint".localized
        default:
            break
        }
        return cell
    }
    
    // função pra lidar com o clique no checkmark (salva no core data)
    @objc func buttonTapped(sender: UIButton) {
        Vibration.shared.vibrate2(for: .medium)
        let subGoal = subItems[sender.tag]
        let dao = DataAcessObject()
        dao.toggleIsCompleted(subGoal: subGoal)
        checkSubGoalsCompletion()
        movePenguin(for: subGoal)
        tableView.reloadData()
    }
    
    func movePenguin(for subGoal: SubGoal) {
        let totalWidth = gradientView.frame.width - 65
        let halfWidth = totalWidth / 2

        // quantidade de cada task
        let easyTasks = subItems.filter { $0.level == "easy" }.count
        let mediumTasks = subItems.filter { $0.level == "medium" }.count
        let hardTasks = subItems.filter { $0.level == "hard" }.count

        // conta quantidade de subgoals de wellness
        let personalSubGoalsCount = subItems.filter { $0.type == "personal" }.count
        let wellnessMovement = halfWidth / CGFloat(personalSubGoalsCount)
        
        // peso de cada task
        let easyWeight = CGFloat(easyTasks * 1)
        let mediumWeight = CGFloat(mediumTasks * 2)
        let hardWeight = CGFloat(hardTasks * 3)

        // total de movimento possivel
        let totalPossibleMovement = easyWeight + mediumWeight + hardWeight

        // quantos pontos pode andar
        let movementPerPoint = halfWidth / totalPossibleMovement

        // movimento
        var movement: CGFloat = 0

        // calcula o movimento baseado no level
        switch subGoal.level {
        case "easy":
            movement = movementPerPoint * 1
        case "medium":
            movement = movementPerPoint * 2
        case "hard":
            movement = movementPerPoint * 3
        default:
            break
        }

        // posição do pinguim
        switch subGoal.type {
        case "work":
            if subGoal.isCompleted {
                imageViewCenterXConstraint?.constant -= movement
            } else {
                imageViewCenterXConstraint?.constant += movement
            }
        case "personal":
            if subGoal.isCompleted {
                imageViewCenterXConstraint?.constant += wellnessMovement
            } else {
                imageViewCenterXConstraint?.constant -= wellnessMovement
            }
        default:
            imageViewCenterXConstraint?.constant = 0
        }

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
            var newIndex = 2


        let penguinPosition = imageViewCenterXConstraint?.constant ?? 0
        UserDefaults.standard.set(penguinPosition, forKey: "PenguinPosition")


            if penguinPosition < -halfWidth * 2 / 4 {
                newIndex = 0
            } else if penguinPosition < -halfWidth / 4 {
                newIndex = 1
            } else if penguinPosition > halfWidth / 4 {
                newIndex = 3
            } else if penguinPosition > halfWidth * 2 / 4 {
                newIndex = 4
            }

            index = newIndex
            updatePhrases()
    }
    
    func updatePhrases() {
        label.text = phrases[index]
        
        if let savedPosition = UserDefaults.standard.value(forKey: "PenguinPosition") as? CGFloat {
            imageViewCenterXConstraint?.constant = savedPosition
            UIView.animate(withDuration: 0.0) { [weak self] in
                self?.view.layoutIfNeeded()
            }
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
                congratulationsViewController.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(congratulationsViewController, animated: true)
                Vibration.shared.vibrate(for: .success)
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

// MARK: Tips -

struct CreateGoalTip: Tip {
    var id: String
    var title: Text {
        Text("Cria uma nova meta")
    }
    var message: Text?{
        Text("Criar uma nova meta e comecar sua jornada")
    }
}
