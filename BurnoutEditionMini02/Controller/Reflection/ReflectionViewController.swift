//
//  ReflectionViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class ReflectionViewController: UIViewController {
    
    // MARK: - Variáveis
    
    // MARK: Célula de nova reflection
    // Botão da célula
    let newRefBt = UIButton()
    
    // Label da célula
    let cellNewRefLabel = UILabel()
    
    // Shape retangular
    let cellNewRefShape = UIView()
    
    // MARK: SearchBar
    let searchBar = UISearchBar()
    
    // MARK: StackView das reflections
    let refStackView = UIStackView()
    
    // MARK: ScrollView
    let scrollView = UIScrollView()
    
    // MARK: ContentView que engloba botão de nova reflection e células de reflections passadas
    let contentView = UIView()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cor de fundo da View
        view.backgroundColor = .systemBackground
        self.title = "Reflection"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Funções setup
        setupNewRefCell()
        setupSearchBar()
        setupRefCells()
        setupScrollView()
        
        // Constraints
        constraints()
    }
    
    // MARK: - ScrollView
    private func setupScrollView() {
        // Configuração da ScrollView
        contentView.addSubview(cellNewRefShape)
        contentView.addSubview(refStackView)
        
        scrollView.addSubview(contentView)
        
        view.addSubview(scrollView)
    }
    
    // MARK: - Célula das reflections passadas
    private func setupRefCells() {
        
        // MARK: TESTE
        let id = UUID()
        let id2 = UUID()
        let testeGoal = GoalStatic(id: id, title: "título teste")
        let teste = ReflectionModel(id: id2, name: "Minha reflection", relatedGoal: testeGoal, randomRefQst: "fodase??", randomRefAns: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam pellentesque erat vel sem cursus auctor. Nulla tincidunt eu libero sit amet bibendum. Fusce at sapien", draw: nil, mood: "😃", date: "29 SET")
        let reflections: [ReflectionModel] = [teste, teste, teste, teste, teste, teste, teste]
        
        // MARK: FIM TESTE
        
        // Configuração da StackView
        refStackView.axis = .vertical
        refStackView.alignment = .center
        refStackView.spacing = 20
        
        for reflection in reflections {
            // Botão da célula
            let refBt = UIButton()
            
            // Círculo atrás do mood
            let refCircleBg = UIView()
            
            // Mood da célula
            let refMood = UILabel()
            
            // Título da reflection
            let refTitle = UILabel()
            
            // Data da reflection
            let refDate = UILabel()
            
            // Divider
            let refDiv = UIView()
            
            // Reflection (texto, desenho ou imagem)
            let refText = UILabel()
            //var refImage: UIImage?
            
            // Configuração do botão
            refBt.setTitle("", for: .normal)
            refBt.backgroundColor = .systemGray4
            refBt.layer.cornerRadius = 10
                        
            // Configuração do background do mood
            refCircleBg.backgroundColor = .systemGray6
            refCircleBg.layer.cornerRadius = view.frame.width / 9.6
            refBt.addSubview(refCircleBg)
            
            // Configuracão do mood
            refMood.text = reflection.mood
            refMood.font = UIFont.systemFont(ofSize: 50)
            refBt.addSubview(refMood)
            
            // Configuração da label TÍTULO DA REFLECTION
            refTitle.text = reflection.name
            refTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            refBt.addSubview(refTitle)
            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM"
//            let formattedDate = dateFormatter.string(from: reflection.date ?? Date())
//            
            // Configuração da data
            refDate.text = reflection.date.uppercased()
            refDate.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            refBt.addSubview(refDate)
            
            // Configuração do divider
            refDiv.backgroundColor = .systemGray
            refBt.addSubview(refDiv)
            
            // Configuração do texto da reflection
            refText.text = reflection.randomRefAns
            refText.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            refText.numberOfLines = 3
            refBt.addSubview(refText)
            
            // StackView das células das reflections
            refStackView.addArrangedSubview(refBt)
            view.addSubview(refStackView)
            
            // Constraints
            // Botão (background)
            refBt.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refBt.widthAnchor.constraint(equalToConstant: view.frame.width - 64),
                refBt.heightAnchor.constraint(equalToConstant: view.frame.height / 8.2)
            ])
            
            // Mood background
            refCircleBg.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refCircleBg.widthAnchor.constraint(equalToConstant: view.frame.width / 4.8),
                refCircleBg.heightAnchor.constraint(equalToConstant: view.frame.width / 4.8),
                refCircleBg.centerYAnchor.constraint(equalTo: refBt.centerYAnchor),
                refCircleBg.leadingAnchor.constraint(equalTo: refBt.leadingAnchor, constant: 16)
            ])
            
            // Mood
            refMood.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refMood.centerXAnchor.constraint(equalTo: refCircleBg.centerXAnchor),
                refMood.centerYAnchor.constraint(equalTo: refCircleBg.centerYAnchor)
            ])
            
            // Título da Reflection
            refTitle.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refTitle.topAnchor.constraint(equalTo: refBt.topAnchor, constant: 10),
                refTitle.leadingAnchor.constraint(equalTo: refCircleBg.trailingAnchor, constant: 16)
            ])
            
            // Data
            refDate.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refDate.topAnchor.constraint(equalTo: refTitle.topAnchor),
                refDate.trailingAnchor.constraint(equalTo: refBt.trailingAnchor, constant: -16)
            ])
            
            // Divider
            refDiv.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refDiv.leadingAnchor.constraint(equalTo: refTitle.leadingAnchor),
                refDiv.trailingAnchor.constraint(equalTo: refBt.trailingAnchor),
                refDiv.topAnchor.constraint(equalTo: refTitle.bottomAnchor),
                refDiv.heightAnchor.constraint(equalToConstant: 1)
            ])
            
            // Texto
            refText.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                refText.leadingAnchor.constraint(equalTo: refDiv.leadingAnchor),
                refText.trailingAnchor.constraint(equalTo: refDate.trailingAnchor),
                refText.topAnchor.constraint(equalTo: refDiv.bottomAnchor, constant: 5),
                refText.bottomAnchor.constraint(equalTo: refBt.bottomAnchor, constant: -16)
            ])
            
            // Ação do botão
            refBt.addTarget(self, action: #selector(goToRefView), for: .touchUpInside)
        }
    }
    
    @objc func goToRefView() {
        
    }
    
    // MARK: - Search bar
    func setupSearchBar() {
        // Configuracões da Search Bar
        searchBar.placeholder = "Search"
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.searchBarStyle = .prominent
        
        view.addSubview(searchBar)
    }
    
    // MARK: - Célula de nova reflexão
    func setupNewRefCell() {
        
        view.addSubview(cellNewRefShape)
        
        // Configurações do botão
        newRefBt.setTitle("New Reflection", for: .normal)
        newRefBt.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        newRefBt.backgroundColor = .systemBlue
        newRefBt.layer.cornerRadius = 18
        cellNewRefShape.addSubview(newRefBt)
        
        newRefBt.addTarget(self, action: #selector(goToNewReflection), for: .touchUpInside)
        
        // Configurações da label
        cellNewRefLabel.text = "What about a break to reflect about your journey?"
        cellNewRefLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cellNewRefLabel.numberOfLines = 5
        cellNewRefShape.addSubview(cellNewRefLabel)
        
        // Configurações do fundo da célula
        cellNewRefShape.backgroundColor = .systemGray4
        cellNewRefShape.layer.cornerRadius = 10
    }
    
    @objc func goToNewReflection() {
        let nextScreen = BreathAnimationViewController()
        nextScreen.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - Constraints
    private func constraints() {
        // Search Bar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width - 16)
        ])
        
        // MARK: Célula de nova reflection
        // Fundo da célula
        cellNewRefShape.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellNewRefShape.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cellNewRefShape.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            cellNewRefShape.heightAnchor.constraint(equalToConstant: view.frame.height / 5.5),
            cellNewRefShape.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        // Label da célula
        cellNewRefLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellNewRefLabel.leadingAnchor.constraint(equalTo: cellNewRefShape.leadingAnchor, constant: 16),
            cellNewRefLabel.topAnchor.constraint(equalTo: cellNewRefShape.topAnchor, constant: 16),
            cellNewRefLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2)
        ])
        
        // Botão da célula
        newRefBt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newRefBt.leadingAnchor.constraint(equalTo: cellNewRefShape.leadingAnchor, constant: 16),
            newRefBt.bottomAnchor.constraint(equalTo: cellNewRefShape.bottomAnchor, constant: -16),
            newRefBt.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            newRefBt.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        // MARK: Célula das reflections passadas
        refStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refStackView.topAnchor.constraint(equalTo: cellNewRefShape.bottomAnchor, constant: 26),
            refStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            refStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            refStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // MARK: ScrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // MARK: Content View
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
