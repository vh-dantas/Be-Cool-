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
        label.text = "achievements-text".localized
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // Imagem do meio da tela de conquistas
   private let achievIamge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PenguinAchiev")
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
    private var contentAchievView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        view.backgroundColor = UIColor(named: "BackgroundColor")
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
        // Configurando o tamanho da fonte para iPad
        if view.frame.height >= 1100 {
            jorneyLabel.font = UIFont.preferredFont(forTextStyle: .title3) //title3
        } else {
            jorneyLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        }
    }
    
    // MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        // Confirmando que a CollectionView sempre estará atualizada
        achievementArray = DataAcessObject.shared.fetchGoal()
        self.achievCollectionView.reloadData()
        
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
            jorneyLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2.5)
        ])
    }
    // Configurando a imagem Superior - ela fic ano meio ta topContainer View
    func setUpAchievementImage(){
        topContainerView.addSubview(achievIamge)
        NSLayoutConstraint.activate([
            achievIamge.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            achievIamge.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            achievIamge.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.8),
            achievIamge.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.8)
//            achievIamge.widthAnchor.constraint(equalToConstant: 227),
//            achievIamge.heightAnchor.constraint(equalToConstant: 256)
        ])
    }
    
    // MARK: COllectionView
    func setUpCollectionView() {
        achievCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        achievCollectionView.register(AchievementCell.self, forCellWithReuseIdentifier: AchievementCell.reuseIdentifier)
        view.addSubview(contentAchievView)
        // Adicionando a collectionView no container
        contentAchievView.addSubview(achievCollectionView)
        // Deixando ele flexivel para os lados e cima e baixo
        achievCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        achievCollectionView.backgroundColor = .systemBackground
        achievCollectionView.translatesAutoresizingMaskIntoConstraints = false
        achievCollectionView.dataSource = self
        achievCollectionView.delegate = self
        NSLayoutConstraint.activate([
            contentAchievView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            contentAchievView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentAchievView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            contentAchievView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
        // Caso seja um iphone ao container centraliza a collectionview
        if view.frame.height >= 1000 {
            NSLayoutConstraint.activate([
                //CollectionView
                achievCollectionView.topAnchor.constraint(equalTo: contentAchievView.topAnchor),
                achievCollectionView.bottomAnchor.constraint(equalTo: contentAchievView.bottomAnchor),
                achievCollectionView.leadingAnchor.constraint(equalTo: contentAchievView.leadingAnchor, constant: 50),
                achievCollectionView.trailingAnchor.constraint(equalTo: contentAchievView.trailingAnchor, constant: -50),
                achievCollectionView.centerXAnchor.constraint(equalTo: contentAchievView.centerXAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                //CollectionView
                achievCollectionView.topAnchor.constraint(equalTo: contentAchievView.topAnchor),
                achievCollectionView.bottomAnchor.constraint(equalTo: contentAchievView.bottomAnchor),
                achievCollectionView.leadingAnchor.constraint(equalTo: contentAchievView.leadingAnchor, constant: 0),
                achievCollectionView.trailingAnchor.constraint(equalTo: contentAchievView.trailingAnchor, constant: 0),
            ])
        }
    }

    // MARK: FloyLayot
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        
        //  flowLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        // Defina o tamanho mínimo dos itens (largura e altura)
        let minItemWidth: CGFloat = (view.frame.height * 0.11)// Largura mínima desejada para cada item
        //let minItemHeight: CGFloat = (view.frame.height * 0.11) // Altura mínima desejada para cada item
        
        // Calcula o número de colunas com base na largura da tela
        let screenWidth = UIScreen.main.bounds.width
        let numberOfColumns = Int(screenWidth / minItemWidth)
        
        // Calcula o tamanho real dos itens com base no número de colunas
//        let itemWidth = screenWidth / CGFloat(numberOfColumns)
//        let itemHeight = minItemHeight // Mantém a altura fixa
        
        flowLayout.itemSize = CGSize(width: 78, height: 89)
        
        // Define o espaçamento entre os itens e as seções conforme necessário
        // flowLayout.minimumInteritemSpacing = 5
        // Padding top em cada item - se for de iPad ele é maior
        flowLayout.minimumLineSpacing = 24
        if view.frame.height >= 1100 {
            flowLayout.minimumLineSpacing = 24
        }
        //flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        
        return flowLayout
    }
   


}

extension AchievementsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  achievementArray.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Criando a Celula
        guard let cell = achievCollectionView.dequeueReusableCell(withReuseIdentifier: AchievementCell.reuseIdentifier, for: indexPath) as? AchievementCell else { fatalError("Cannot Convert cell") }
        let goal = achievementArray[indexPath.row]
        cell.imageCellLabel.text = goal.title
        cell.iPadSetUp(view: self)
        // Mudando a imagem se a pessoa completou toda a conquista
        if goal.isCompleted{
            cell.imageCell.image = UIImage(named: "Achievement.fill")
        } else {
            cell.imageCell.image = UIImage(named: "Achievement.Normal2")
        }
        // Configurando a imagem da Celula
       // cell.layer.borderWidth = 2
        return cell

    }
    // MARK: FUNCOES AREAS DE TESTE
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return  90
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // Criando a Celula
//        guard let cell = achievCollectionView.dequeueReusableCell(withReuseIdentifier: AchievementCell.reuseIdentifier, for: indexPath) as? AchievementCell else { fatalError("Cannot Convert cell") }
//        cell.imageCellLabel.text = "Paralelepipedo Paralelepipedo"
//        cell.iPadSetUp(view: self)
//        cell.imageCell.image = UIImage(named: "Achievement.fill")
//        return cell
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = indexPath.item
        let achievDetail = AchievementDetailViewController(goal: achievementArray[itemSelected])
      // navigationController?.pushViewController(achievDetail, animated: true)
    }
}


// MARK: Achievement Cell - Celula componntesada para a collection view
class AchievementCell: UICollectionViewCell {
    
    // Criando o identificador do register
    static let reuseIdentifier = "achievCell-reuse-identifier"
    
    let imageCell: UIImageView = {
        let imageView = UIImageView()
        //    imageView.image = UIImage(named: "Achievement.Normal2")
        imageView.layer.borderColor = UIColor.black.cgColor
        //    imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
    
    
    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageCell)
        contentView.addSubview(imageCellLabel)
        // Constraints da Imagem da celula
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageCell.heightAnchor.constraint(equalToConstant: 60),
            imageCell.widthAnchor.constraint(equalToConstant: 60)

        ])
        // Constraints do texto da celula
        NSLayoutConstraint.activate([
            imageCellLabel.topAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 3),
            imageCellLabel.centerXAnchor.constraint(equalTo: imageCell.centerXAnchor),
            imageCellLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
       
//        // Definindo o corner radius - ele pega as medidas da tela, multipica pelo tamanho da imagem e divide pela metade para trasnformar me circulo
//        imageCell.layer.cornerRadius = min(contentView.frame.width * 0.85, contentView.frame.height * 0.85) / 2.0
//        imageCell.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Funcoes
    
    // Função para alterar coisas para o iPad
    func iPadSetUp(view: AchievementsViewController){
        // Configurando o tamanho da fonte para iPad
        if view.view.frame.height >= 1000 {
            imageCellLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        } else {
            imageCellLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        }
    }
}
