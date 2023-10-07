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
        table.isScrollEnabled = true
        table.layer.cornerRadius = 10
        return table
    }()
    // Ultima Label antes das tarefas de trabalho
    private let lastWellNessLabel: UILabel = {
        let label = UILabel()
        label.text = "Isso demonstra o quanto cuidar de si mesmo é essencial para alcançar o sucesso."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Ala de trabalho
    // Titulo trabalho
    private let workTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tarefas de trabalho"
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let workTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isEditing = false
        table.isScrollEnabled = true
        table.layer.cornerRadius = 10
        return table
    }()
    
    private let finalLabel: UILabel = {
        let label = UILabel()
        label.text = "Dividir metas em tarefas tornou o impossível possível. Pequenos passos levaram a grandes realizações!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    // Progress bar de nivel das metas de trabalho - grafico com %
    private let progressBar = UIView()

    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Nome da Meta"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        // Adicionando todas as views
        addToView()
        // Funções de SetUp
        setUpDateImage()
        setUpDateLabel()
        setUpWellBeingTitleLabel()
        setUpWellBeingTextLabel()
        setupTimeCard()
        setUpWellNessTableView()
        setUPLasLabel()
        // Trabalhas
        setUpWorkTitleLabel()
        setUpProgressBar()
        setUpWorkTableView()
        setUpFinalLabel()
        
        
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
    
    // Função para adicionar todos na view
    func addToView(){
        view.addSubview(dateLabel)
        view.addSubview(dateImage)
        view.addSubview(stackView)
        view.addSubview(wellBeingTitleLabel)
        view.addSubview(wellBeingTextLabel)
        view.addSubview(wellNessTableView)
        view.addSubview(lastWellNessLabel)
        // Trabalhas
        view.addSubview(workTitleLabel)
        view.addSubview(progressBar)
        view.addSubview(workTableView)
        view.addSubview(finalLabel)
    }
    
    // MARK: SetUpDateLabel
    func setUpDateLabel() {
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
        NSLayoutConstraint.activate([
            wellBeingTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 4),
            wellBeingTitleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1),
            wellBeingTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
    }
    // MARK: SetUp WellBeingTextLabel
    func setUpWellBeingTextLabel(){
        NSLayoutConstraint.activate([
            wellBeingTextLabel.topAnchor.constraint(equalToSystemSpacingBelow: wellBeingTitleLabel.bottomAnchor, multiplier: 2),
            wellBeingTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            wellBeingTextLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
    }
    // MARK: Relogio de horas - Obrigado Thayná 🙏
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
        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: wellBeingTextLabel.bottomAnchor, multiplier: 3)
        ])
    }
    
    //MARK: WELLNESS TABLEVIEW
    func setUpWellNessTableView(){
        wellNessTableView.dataSource = self
        wellNessTableView.register(AchievementTableViewCell.self, forCellReuseIdentifier: AchievementTableViewCell.reuseIdentifier)
        wellNessTableView.separatorInset = UIEdgeInsets(top: 0, left: 38, bottom: 0, right: 0)
        var constant: Double = 0.2
        if wellNessTableView.numberOfRows(inSection: 0) < 4 {
            constant = 0.1
        }
        NSLayoutConstraint.activate([
            wellNessTableView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 3),
            wellNessTableView.bottomAnchor.constraint(equalTo: lastWellNessLabel.topAnchor, constant: -20),
            wellNessTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            wellNessTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wellNessTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: constant)
        ])
    }
    
    //MARK: LastLabel
    func setUPLasLabel() {
        NSLayoutConstraint.activate([
            lastWellNessLabel.topAnchor.constraint(equalToSystemSpacingBelow: wellNessTableView.bottomAnchor, multiplier: 1),
            lastWellNessLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            lastWellNessLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
    }
    
    // MARK: TRABALHAS FUNCS
    func setUpWorkTitleLabel() {
        NSLayoutConstraint.activate([
            workTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: lastWellNessLabel.bottomAnchor, multiplier: 4),
            workTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            workTitleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1),
        ])
    }
    
    // MARK: PogressBar - função para fazer a barra de % de dificuldade das metas
    func setUpProgressBar(){
        progressBar.backgroundColor = UIColor.lightGray
        progressBar.layer.cornerRadius = 13
        // Crie as subviews coloridas - cada cor representa uma dificuldade
        let colorView1 = UIView()
        colorView1.backgroundColor = UIColor(named: "EasyWork")
        // Definindo qual cantos quero arrendondar
        colorView1.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        colorView1.layer.cornerRadius = 13
        progressBar.addSubview(colorView1)
        
        let colorView2 = UIView()
        colorView2.backgroundColor = UIColor(named: "MediumWork")
        progressBar.addSubview(colorView2)
        
        let colorView3 = UIView()
        colorView3.backgroundColor = UIColor(named: "HardWork")
        // Definindo qual cantos quero arrendondar
        colorView3.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        colorView3.layer.cornerRadius = 13
        progressBar.addSubview(colorView3)
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        colorView1.translatesAutoresizingMaskIntoConstraints = false
        colorView2.translatesAutoresizingMaskIntoConstraints = false
        colorView3.translatesAutoresizingMaskIntoConstraints = false
        
        // Calcule as larguras com base no percentual (30%, 40%, 30%)
        var easyWork: Int = 0
        var mediumWork:Int = 0
        var hardWork: Int = 0
        // Loop para identificar a dificuldade das submetas
//        if let goal = goal {
//            for subGoals in goal.subGoalsArray {
//                switch subGoals.dificulty {
//                case "easy":
//                    easyWork += 1
//                case "medium":
//                    mediumWork += 1
//                case "hard":
//                    hardWork += 1
//                default:
//                    print("Dificuldade não encontrada")
//                }
//            }
//        }
        // Calculando a porcentagem %
//        let totalWorkGoals: Int = easy + medium + hard
//        let width1 =  (easy/totalWorkGoals) * 100
//        let width2 =  (medium/totalWorkGoals) * 100
//        let width3 =  (hard/totalWorkGoals) * 100
        let width1 =  0.2
        let width2 =  0.5
        let width3 =  0.3
        
        // Criando o indice do grafico
        //      let indiceStackView = UIStackView() // configurando a StackView
        //        indiceStackView.axis = .horizontal
        //        indiceStackView.spacing = 1
        //        indiceStackView.distribution = .fillEqually
        //        indiceStackView.alignment = .leading
        //        indiceStackView.addArrangedSubview(easyPercent)
        //        indiceStackView.addArrangedSubview(mediumPercent)
        //        indiceStackView.addArrangedSubview(hardPercent)
        //        indiceStackView.translatesAutoresizingMaskIntoConstraints = false
        //        view.addSubview(indiceStackView)
        // Criando as bolinhas do indice do grafico
        let easyPercent = PercentualComponent(frame: CGRect(), color: UIColor(named: "EasyWork") ?? .systemGreen, percentagem: width1 * 100, text: "Fácil")
        let mediumPercent = PercentualComponent(frame: CGRect(), color: UIColor(named: "MediumWork") ?? .systemYellow, percentagem: width2 * 100, text: "Médio")
        let hardPercent = PercentualComponent(frame: CGRect(), color: UIColor(named: "HardWork") ?? .systemRed, percentagem: width3 * 100, text: "Difícil")

        view.addSubview(easyPercent)
        view.addSubview(mediumPercent)
        view.addSubview(hardPercent)
        easyPercent.translatesAutoresizingMaskIntoConstraints = false
        mediumPercent.translatesAutoresizingMaskIntoConstraints = false
        hardPercent.translatesAutoresizingMaskIntoConstraints = false
        // Atualize o layout das subviews - cada color recebe uma width com sua porcentagem na barra
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalToSystemSpacingBelow: workTitleLabel.bottomAnchor, multiplier: 2),
            progressBar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 2),
            progressBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            progressBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            progressBar.heightAnchor.constraint(equalToConstant: 25),
            // Constraints da Color 1
            colorView1.topAnchor.constraint(equalTo: progressBar.topAnchor),
            colorView1.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            colorView1.bottomAnchor.constraint(equalTo: progressBar.bottomAnchor),
            colorView1.widthAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: width1),
            colorView1.heightAnchor.constraint(equalTo: progressBar.heightAnchor, multiplier: 1),
            //C Constraints da color 2
            colorView2.topAnchor.constraint(equalTo: progressBar.topAnchor),
            colorView2.leadingAnchor.constraint(equalTo: colorView1.trailingAnchor),
            colorView2.bottomAnchor.constraint(equalTo: progressBar.bottomAnchor),
            colorView2.widthAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: width2),
            colorView2.heightAnchor.constraint(equalTo: progressBar.heightAnchor, multiplier: 1),
            // Constraints da color 3
            colorView3.topAnchor.constraint(equalTo: progressBar.topAnchor),
            colorView3.leadingAnchor.constraint(equalTo: colorView2.trailingAnchor),
            colorView3.bottomAnchor.constraint(equalTo: progressBar.bottomAnchor),
            colorView3.widthAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: width3),
            colorView3.heightAnchor.constraint(equalTo: progressBar.heightAnchor),
            // Indice
            easyPercent.topAnchor.constraint(equalToSystemSpacingBelow: progressBar.bottomAnchor, multiplier: 2),
            easyPercent.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3.5),
            mediumPercent.topAnchor.constraint(equalToSystemSpacingBelow: progressBar.bottomAnchor, multiplier: 2),
            mediumPercent.leadingAnchor.constraint(equalToSystemSpacingAfter: easyPercent.trailingAnchor, multiplier: 11),
            hardPercent.topAnchor.constraint(equalToSystemSpacingBelow: progressBar.bottomAnchor, multiplier: 2),
            hardPercent.leadingAnchor.constraint(equalToSystemSpacingAfter: mediumPercent.trailingAnchor, multiplier: 12 ),
        ])
    }
    
    func setUpWorkTableView(){
        workTableView.dataSource = self
        workTableView.register(AchievementTableViewCell.self, forCellReuseIdentifier: AchievementTableViewCell.reuseIdentifier)
        workTableView.separatorInset = UIEdgeInsets(top: 0, left: 38, bottom: 0, right: 0)
        var constant: Double = 0.2
        if workTableView.numberOfRows(inSection: 0) < 4 {
            constant = 0.1
        }
        NSLayoutConstraint.activate([
            workTableView.topAnchor.constraint(equalToSystemSpacingBelow: progressBar.bottomAnchor, multiplier: 7),
          //  workTableView.bottomAnchor.constraint(equalTo: lastWellNessLabel.topAnchor, constant: -20),
            workTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            workTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            workTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: constant)
        ])
    }
    
    func setUpFinalLabel() {
        NSLayoutConstraint.activate([
            finalLabel.topAnchor.constraint(equalToSystemSpacingBelow: workTableView.bottomAnchor, multiplier: 1),
            finalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            finalLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
    }
}

// MARK: Celula da DataSourceDelegate ----------------------------------
extension AchievementDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // Retorna as celulas que preenchem as rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cria a celula da UITableView
//        if goal?.subGoalsArray[indexPath.row].type == "WellNess" {
//            guard let cell = wellNessTableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.reuseIdentifier, for: indexPath) as? AchievementTableViewCell else { fatalError("Cannot Convert cell") }
//            // Pega os elementos presentes na array e passa cada uma para uma row
//            cell.cellLabel.text = goal?.subGoalsArray[indexPath.row].title
//            cell.image.image = UIImage(systemName: "checkmark.circle.fill")
//            cell.tintColor = UIColor(named: "IconBlueWork")
//       cell.backgroundColor = UIColor(named: "BgGreenWell")
//            return cell
//        } else {
//            guard let cell = workTableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.reuseIdentifier, for: indexPath) as? AchievementTableViewCell else { fatalError("Cannot Convert cell") }
//            // Pega os elementos presentes na array e passa cada uma para uma row
//            cell.cellLabel.text = goal?.subGoalsArray[indexPath.row].title
//            cell.image.image = UIImage(systemName: "heart.fill")
//            cell.tintColor = UIColor(named: "IconGreenWell")
          
//            return cell
//        }
        
        guard let cell = wellNessTableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.reuseIdentifier, for: indexPath) as? AchievementTableViewCell else { fatalError("Cannot Convert cell") }
        // Pega os elementos presentes na array e passa cada uma para uma row
        cell.cellLabel.text = "Teste"
        cell.image.image = UIImage(systemName: "heart.fill")
        cell.tintColor = UIColor(named: "IconGreenWell")
        cell.backgroundColor = UIColor(named: "BgGreenWell")
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
      //  contentView.backgroundColor = UIColor(named: "BgGreenWell")
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
