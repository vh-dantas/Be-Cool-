//
//  AchievementsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class AchievementsViewController: UIViewController {

    // View Container
    private let topContainerView = UIView()
    
    //UILAbel abaixo do title
    private let jorneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Relembre Sua Jornada e Celebre Suas Conquistas!"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // Imagem do meio da tela de conquistas
   private let achievIamge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WinnerGuin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Componentes para listar toda as conquistas
    private let achievementCell = UIView()
    
    
    private let imageCell: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "FunnyGuin")
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let imageCellLabel: UILabel = {
       let label = UILabel()
        label.text = "Paralelepipedo Paralelepipedo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        // Para ele ficar no centro em relacao ao circulo da foto
        label.textAlignment = .center
        return label
    }()
    
    //  CollectionView
    private var achievCollectionView: UICollectionView! = nil
    
    // Variável que coleta o tamanho da view
    private  let viewToConstrain = UIView()
    
    // Dados para preencher a view
    private var achievementArray: [Goal] = []
    

    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "achievements".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        // Codigo relacionado as variáveis populadas
        achievementArray = DataAcessObject.shared.fetchGoal()
        // Funções de SetUp
        setUpCntainerViews()
        setUPJorneyLabel()
        setUpAchievementImage()
        setUpImageCell()
        setUpImageCellLabel()
        setUpCollectionView()
        // Configurações adicionais que nao cabem dentro da clousure da View
      // recebe o tamanho da view * o tamanho da imagem e divide para arredondar
     
       
        
    }
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Atualize o cornerRadius com base na orientação do dispositivo
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
//            let cornerRadius = (view.frame.height * 0.1) / 2.9
//            imageCell.layer.cornerRadius = cornerRadius
            // Criando um for loop para atualizar o corner radius de cada item na array
            for achievment in 0..<(achievementArray.count){
                let indexPath = IndexPath(item: achievment, section: 0)
                // acessando o item diretamente através do método cellForItem(at:)
                if let cell = achievCollectionView.cellForItem(at: indexPath) as? AchievementCell {
                    cell.imageCellLabel.layer.cornerRadius = (view.frame.height * 0.1) / 2.9
                    cell.imageCellLabel.layer.masksToBounds = true
                }
            }
        } else {
            print("Portrait")
//            let cornerRadius = (view.frame.height * 0.1) / 1.41
//            imageCell.layer.cornerRadius = cornerRadius
            // Criando um for loop para atualizar o corner radius de cada item na array
            for achievment in 0..<(achievementArray.count){
                let indexPath = IndexPath(item: achievment, section: 0)
                // acessando o item diretamente através do método cellForItem(at:)
                if let cell = achievCollectionView.cellForItem(at: indexPath) as? AchievementCell {
                    cell.imageCellLabel.layer.cornerRadius = (view.frame.height * 0.1) / 1.41
                    cell.imageCellLabel.layer.masksToBounds = true
                }
            }
        }
 
    }
    
    // Convfigurando todos os Container Views - ela preenche metade da view
    func setUpCntainerViews(){
        view.addSubview(topContainerView)
        topContainerView.backgroundColor = .gray
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
        ])
    }
    
    // Configurando a Jorney Label MARK: JorneyLabel
    func setUPJorneyLabel(){
        topContainerView.addSubview(jorneyLabel)
        NSLayoutConstraint.activate([
            jorneyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            jorneyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func setUpCollectionView() {
         achievCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: <#T##UICollectionViewLayout#>)
        
        achievCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        achievCollectionView.backgroundColor = .systemBackground
        achievCollectionView.translatesAutoresizingMaskIntoConstraints = false
        achievCollectionView.register(AchievementCell.self, forCellWithReuseIdentifier: AchievementCell.reuseIdentifier)
        achievCollectionView.dataSource = self
        view.addSubview(achievCollectionView)
        
        
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout{
        
    }
    
    // Configurando a imagem Superior - ela fic ano meio ta topContainer View
    func setUpAchievementImage(){
        topContainerView.addSubview(achievIamge)
        NSLayoutConstraint.activate([
            achievIamge.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            achievIamge.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            achievIamge.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5),
            achievIamge.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5)
        ])
    }
    // Configurando a imagem da celula da UICollectionView que lista as consquistas
    func setUpImageCell(){
        view.addSubview(imageCell)
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 10),
            imageCell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageCell.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            imageCell.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
            
        ])
    }
    
    func setUpImageCellLabel() {
        view.addSubview(imageCellLabel)
        NSLayoutConstraint.activate([
            imageCellLabel.topAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 3),
            imageCellLabel.centerXAnchor.constraint(equalTo: imageCell.centerXAnchor),
            imageCellLabel.widthAnchor.constraint(equalTo: imageCell.widthAnchor)
        ])
    }

}

extension AchievementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        achievementArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Criado a celula e garantoidno que ela seja do tipo AchievementCell
        guard let cell = achievCollectionView.dequeueReusableCell(withReuseIdentifier: AchievementCell.reuseIdentifier, for: indexPath) as? AchievementCell else { fatalError("Cannot Convert cell") }
        cell.imageCellLabel.text = achievementArray[indexPath.item].title
        cell.imageCell.layer.cornerRadius = (view.frame.height * 0.1) / 2
        
        return cell
    }
}



// MARK: Achievement Cell
     

class AchievementCell: UICollectionViewCell {
    
    // Criando o identificador do register
    static let reuseIdentifier = "achievCell-reuse-identifier"
    
     let imageCell: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "FunnyGuin")
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
     let imageCellLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        // Para ele ficar no centro em relacao ao circulo da foto
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageCell)
        contentView.addSubview(imageCellLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
