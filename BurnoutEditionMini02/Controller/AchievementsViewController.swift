//
//  AchievementsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class AchievementsViewController: UIViewController {

    //UILAbel abaixo do title
    let jorneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Relembre Sua Jornada e Celebre Suas Conquistas!"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "achievements".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        // Funções de SetUp
        setUPJorneyLabel()
    }
  
    // Configurando a Jorney Label MARK: JorneyLabel
    func setUPJorneyLabel(){
        view.addSubview(jorneyLabel)
        NSLayoutConstraint.activate([
            jorneyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            jorneyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }

}


// MARK: Table View


//class SubGoalViewController: UIViewController {
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.dataSource = self
//        // tirar as linhas de separacao
//        tableView.separatorStyle = .none
//        // ajusta a ditencia entre as celulas
//        // tableView.separatorInset = .init(top: 80, left: 100, bottom: 40, right: 50)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.delegate = self
//        return tableView
//    }()
//
//    // MARK: Coisas do core data
//
//
//    // Table View Data
//    private var subItems:[SubGoal] = []
//    public var goalSelected: Goal?
//    let context: NSManagedObjectContext
//
//
//    init( goalSelected: Goal, context: NSManagedObjectContext) {
//        self.goalSelected = goalSelected
//        self.context = context
//        super.init(nibName: nil, bundle: nil) // Call the designated initializer of UIViewController
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
//
//        view.addSubview(tableView)
//        constraintsTableView()
//
//
//         setUpToolBar()
//
//        navigationController?.isToolbarHidden = false
//        //self.subItems = Persistence.shared.fetchSubGoals()
//
//        fetchTasks()
//
//    }
//
//    func fetchTasks() {
//        guard let goal = self.goalSelected,
//              let goalSubGoals = goal.subGoals?.allObjects as? [SubGoal] else {
//            return
//        }
//
//        self.subItems = goalSubGoals
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//
//
//}
//// MARK: Table View
//extension SubGoalViewController: UITableViewDataSource{
//
//
//    // Retorna o número de sections da list
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    // retorna o numero de elementos presentes em cada section
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return subItems.count
//    }
//
//    // Retorna as celulas que preenchem as rows
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // cria a celula da UITableView
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
//        // Pega os elementos presentes na array e passa cada uma para uma row
//        cell.textLabel?.text = subItems[indexPath.row].title //"Celula \(indexPath.item)"
//        return cell
//    }
//
//    // Coloca um title para cada section
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return goalSelected?.title ?? "Meta"
//
//    }
//
//    private func constraintsTableView(){
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//}
//
//
//extension SubGoalViewController: UITableViewDelegate {
//    // Função de trailing swipe
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complettionHandler) in
//            let personToRemove = self.subItems [indexPath.row]
//            //   Persistence.shared.deletePerson(person: personToRemove)
//            self.subItems = self.goalSelected?.subGoalsArray ?? []
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        }
//        return UISwipeActionsConfiguration(actions: [action])
//    }
//
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let personSelected = self.subItems[indexPath.row]
//
//
//
//        let alert = UIAlertController(title: "Editar", message: "Edite o nome da pessoa", preferredStyle: .alert)
//        alert.addTextField()
//
//        let textfield = alert.textFields![0]
//        textfield.text = personSelected.title
//
//        let button = UIAlertAction(title: "Confirm", style: .default) {
//            action in
//            //   let textfield = alert.textFields![0]
//            personSelected.title = textfield.text
//            DataAcessObject.shared.saveContext()
//            self.subItems = self.goalSelected?.subGoalsArray ?? []
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        }
//
//        alert.addAction(button)
//        self.present(alert, animated: true)
//
//    }
//}
//
//
//extension SubGoalViewController {
//    private func setUpToolBar(){
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapButton))
//    }
//
//    @objc private func didTapButton(){
//
//        AlertManager.addAlert(on: self) { string in
//            self.addItem(string)
//
//
//
//        }
//    }
//
//
//
//
//    func addItem(_ item: String){
//        if let goal = goalSelected {
//            DataAcessObject.shared.createSubGoal(title: item, type: "?", goal: goal )
//            let index = 0
//            // subItems.insert(item, at: index)
//            fetchTasks()
//            let indexPath = IndexPath(row: index, section: 0)
//            tableView.insertRows(at: [indexPath], with: .left)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
////    func addItem(_ item: String){
////        let index = 0
////        // subItems.insert(item, at: index)
////
////        let indexPath = IndexPath(row: index, section: 0)
////        let newSubGoal = Persistence.shared.createSubGoal(name: item, type: "Work", goal: goalSelected )
////        goalSelected.addToSubGoals(newSubGoal)
////        self.subItems = goalSelected.subGoals
////        tableView.insertRows(at: [indexPath], with: .left)
////        DispatchQueue.main.async {
////            self.tableView.reloadData()
////        }
////    }
//
//}
//
