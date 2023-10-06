//
//  AchievementDetailViewController.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 06/10/23.
//

import UIKit

class AchievementDetailViewController: UIViewController {
    // meta selecionada na tela de conquistas
    private var goal: Goal?
    // Label da data da conquista
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.text = "28 DE SET DE 2023 - 01 DE OUT DE 2023"
        label.text = label.text?.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    //Imagem da ampulheta ao lado da data
    private let dateImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "hourglass")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    // texto titulo da parte de bem-estar
    private let wellBeingTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Atividades de Bem-Estar"
        label.font = UIFont.preferredFont(forTextStyle: .callout, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.textColor = UIColor.black
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    // texto body do bem estar, acima do relogio
    private let wellBeingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Essas foram as horas ao seu bem-estar enquanto trabalhava para esta meta:"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.black
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    // Numeros Big Label
    let stackView = UIStackView()
    
    // TablesViews das SubGoals
    private let wellNessTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isEditing = false
        table.isScrollEnabled = false
  
        return table
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Nome da Meta"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground

       // Funções de SetUp
        setUpDateImage()
        setUpDateLabel()
        setUpWellBeingTitleLabel()
        setUpWellBeingTextLabel()
        setupTimeCard()
        setUpWellNessTableView()
    }
    
    // MARK: INIT
    init(goal: Goal){
        self.goal = goal
        super.init(nibName: nil, bundle: nil)
    }
    // MARK: Required Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    // MARK: SetUpDateLabel
    func setUpDateLabel() {
        // Adicionando na view
        view.addSubview(dateLabel)
        // Formatando a data
        let date = self.goal?.createdDate ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        let formatedDate = dateFormatter.string(from: date)
        // Mudando o texto da label
        dateLabel.text = "\(formatedDate) - Finalização da meta*"
        dateLabel.text = dateLabel.text?.uppercased()
        dateLabel.textColor = UIColor.gray
        // Criando as constraints
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 17),
            dateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: dateImage.trailingAnchor,multiplier: 0.8)

        ])
    }
    // MARK: SetUpDateImage
    func setUpDateImage() {
        view.addSubview(dateImage)
        // Constraints
        NSLayoutConstraint.activate([
            dateImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  -6),
            dateImage.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            dateImage.widthAnchor.constraint(equalToConstant: 14),
            dateImage.heightAnchor.constraint(equalToConstant: 18),
        ])

    }
    // MARK: SetUpWellBeingTitleLabel
    func setUpWellBeingTitleLabel(){
        view.addSubview(wellBeingTitleLabel)
        NSLayoutConstraint.activate([
            wellBeingTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 4),
            wellBeingTitleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1),
            wellBeingTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
    }
    
    func setUpWellBeingTextLabel(){
        view.addSubview(wellBeingTextLabel)

        NSLayoutConstraint.activate([
            wellBeingTextLabel.topAnchor.constraint(equalToSystemSpacingBelow: wellBeingTitleLabel.bottomAnchor, multiplier: 2),
            wellBeingTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            wellBeingTextLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
    }
    
    // Relogio de horas - Obrigado Thayná 🙏
    func setupTimeCard() {

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // pega o valor da classe calculadora
        let (hours, minutes) = Calculator.shared.calculateResult()
        // transforma o resultado em uma string e separa cada dígito com um .map
        let timeDigits = String(format: "%02d%02d", hours, minutes).map { String($0) }
        
        for index in 0..<4 {
            // Cria um retângulo com as dimensões e posição certas
            let rectangle = UIView()
            rectangle.backgroundColor = UIColor(named: "GreenWell")
            rectangle.layer.cornerRadius = 5
            rectangle.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rectangle.widthAnchor.constraint(equalToConstant: 55),
                rectangle.heightAnchor.constraint(equalToConstant: 70)
            ])

            // Cria a label do cartão
            let timeDigit = UILabel()
            // Adiciona os dígitos no cartão, um por vez
            timeDigit.text = timeDigits[index]
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
        // Adicionando na View
        self.view.addSubview(stackView)
        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: wellBeingTextLabel.bottomAnchor, multiplier: 2)
        ])
    }
    
    //MARK: WELLNESS TABLEVIEW
    func setUpWellNessTableView(){
        view.addSubview(wellNessTableView)
        wellNessTableView.dataSource = self
        wellNessTableView.register(AchievementTableViewCell.self, forCellReuseIdentifier: AchievementTableViewCell.reuseIdentifier)
        NSLayoutConstraint.activate([
            wellNessTableView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
            wellNessTableView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 2),
            wellNessTableView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 1),
            wellNessTableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1)
        ])
    }
}

extension AchievementDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // Retorna as celulas que preenchem as rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cria a celula da UITableView
        guard let cell = wellNessTableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.reuseIdentifier, for: indexPath) as? AchievementTableViewCell else { fatalError("Cannot Convert cell") }
        // Pega os elementos presentes na array e passa cada uma para uma row
        cell.cellLabel.text = "Teste" //"Celula \(indexPath.item)"
        cell.image.image = UIImage(systemName: "heart.fill")
        cell.tintColor = UIColor(named: "IconGreenWell")
        cell.image.image?.withTintColor((UIColor(named: "GreenWell") ?? .green), renderingMode: .alwaysOriginal)
        
        return cell
    }
    
    
}


// MARK: Celula da TableView ----------------------------------
class AchievementTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "table-reuse-identifier"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "GreenWell")
        addSubview(image) // Mova essa linha para cá
        addSubview(cellLabel)
        image.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1), // Mude de contentView.trailingAnchor para contentView.leadingAnchor
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3), // Ajuste o valor conforme necessário
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5), // Ajuste o valor conforme necessário
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            //Label
            cellLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: image.trailingAnchor, multiplier: 1),
            cellLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 1),
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
