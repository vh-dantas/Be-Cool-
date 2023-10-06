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
       // setUpImageCell()
       // setUpImageCellLabel()
        setUpCollectionView()
        // Configurações adicionais que nao cabem dentro da clousure da View
      // recebe o tamanho da view * o tamanho da imagem e divide para arredondar

    }
    
    // Configurando todos os Container Views - ela preenche metade da view MARK: COntainerView
    func setUpCntainerViews(){
        view.addSubview(topContainerView)
        topContainerView.backgroundColor = .systemBackground
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
    
    // MARK: COllectionView
    func setUpCollectionView() {
        achievCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout(section: 1))
        view.addSubview(achievCollectionView)
        achievCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        achievCollectionView.backgroundColor = .systemBackground
        achievCollectionView.translatesAutoresizingMaskIntoConstraints = false
        achievCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            achievCollectionView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            achievCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            achievCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            achievCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }

    // MARK: FloyLayot
    func createFlowLayout(section: Int) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        if section == 0 {
            flowLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        } else {
            // Defina o tamanho mínimo dos itens (largura e altura)
            let minItemWidth: CGFloat = (view.frame.height * 0.11)// Largura mínima desejada para cada item
            let minItemHeight: CGFloat = (view.frame.height * 0.11) // Altura mínima desejada para cada item
            
            // Calcula o número de colunas com base na largura da tela
            let screenWidth = UIScreen.main.bounds.width
            let numberOfColumns = Int(screenWidth / minItemWidth)
            
            // Calcula o tamanho real dos itens com base no número de colunas
            let itemWidth = screenWidth / CGFloat(numberOfColumns)
            let itemHeight = minItemHeight // Mantém a altura fixa
            
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            
            // Define o espaçamento entre os itens e as seções conforme necessário
           // flowLayout.minimumInteritemSpacing = 5
            // Padding top em cada item
            flowLayout.minimumLineSpacing = 30
            //flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        }
        return flowLayout
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

}

extension AchievementsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 2
       }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            collectionView.register(TopCell.self, forCellWithReuseIdentifier: TopCell.reuseIdentifier)
            return 1
        }
        collectionView.register(AchievementCell.self, forCellWithReuseIdentifier: AchievementCell.reuseIdentifier)
        return achievementArray.count
 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Criado a celula e garantoidno que ela seja do tipo AchievementCell
        if indexPath.section == 0 {
            collectionView.register(TopCell.self, forCellWithReuseIdentifier: TopCell.reuseIdentifier)
            guard let cell = achievCollectionView.dequeueReusableCell(withReuseIdentifier: TopCell.reuseIdentifier, for: indexPath) as? TopCell else { fatalError("Cannot Convert cell") }
            // Configurando a imagem da Celula
           
            cell.layer.borderWidth = 2
            return cell
      
        } else {
            achievCollectionView.register(AchievementCell.self, forCellWithReuseIdentifier: AchievementCell.reuseIdentifier)
            guard let cell = achievCollectionView.dequeueReusableCell(withReuseIdentifier: AchievementCell.reuseIdentifier, for: indexPath) as? AchievementCell else { fatalError("Cannot Convert cell") }
            
            cell.imageCellLabel.text = achievementArray[indexPath.item].title
            cell.imageCell.image  = UIImage(named: "FunnyGuin")
            // Configurando a imagem da Celula
            cell.layer.borderWidth = 2
            return cell
        }
    }
}



// MARK: Achievement Cell - Celula componntesada para a collection view
class AchievementCell: UICollectionViewCell {
    
    // Criando o identificador do register
    static let reuseIdentifier = "achievCell-reuse-identifier"
    
     let imageCell: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
         imageView.layer.borderWidth = 3
        return imageView
    }()
    
     let imageCellLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
         label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        // Para ele ficar no centro em relacao ao circulo da foto
        label.textAlignment = .center
        return label
    }()
    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageCell)
        contentView.addSubview(imageCellLabel)
        // Constraints da Imagem da celula
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageCell.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            imageCell.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85)

        ])
        // Constraints do texto da celula
        NSLayoutConstraint.activate([
            imageCellLabel.topAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 3),
            imageCellLabel.centerXAnchor.constraint(equalTo: imageCell.centerXAnchor),
            imageCellLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        // Definindo o corner radius - ele pega as medidas da tela, multipica pelo tamanho da imagem e divide pela metade para trasnformar me circulo
        imageCell.layer.cornerRadius = min(contentView.frame.width * 0.85, contentView.frame.height * 0.85) / 2.0
        imageCell.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class SpecialSectionFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.map { attributes in
            // Faça qualquer modificação necessária em attributes
            // Por exemplo, você pode alterar o tamanho, a posição ou outros atributos.
            return attributes
        }
    }
}

extension AchievementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            collectionView.collectionViewLayout = createFlowLayout(section: 0)
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Espaçamento personalizado
        } else {
            // Use o layout padrão (FlowLayout) para as outras seções
            collectionView.collectionViewLayout = createFlowLayout(section: 1)
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Espaçamento padrão
        }
    }
}



class TopCell: UICollectionViewCell {
    static let reuseIdentifier = "topCell-reuse=identifier"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCntainerViews()
        setUPJorneyLabel()
        setUpAchievementImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configurando todos os Container Views - ela preenche metade da view MARK: COntainerView
    func setUpCntainerViews(){
        contentView.addSubview(topContainerView)
        topContainerView.backgroundColor = .systemBackground
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topContainerView.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
        ])
    }
    
    // Configurando a Jorney Label MARK: JorneyLabel
    func setUPJorneyLabel(){
        topContainerView.addSubview(jorneyLabel)
        NSLayoutConstraint.activate([
            jorneyLabel.topAnchor.constraint(equalTo: topContainerView.safeAreaLayoutGuide.topAnchor),
            jorneyLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor)
        ])
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
}
// MARK: - FIM




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
