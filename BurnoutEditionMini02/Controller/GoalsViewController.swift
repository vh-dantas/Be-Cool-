//
//  GoalsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

// Implementa o protocolo NewGoalModalDelegate
class GoalsViewController: UIViewController, NewGoalModalDelegate {
    
    // Criando uma stack view para mostrar os itens adicionados na modal
    let goalsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical // Define a orientação da stack view como vertical
        stackView.alignment = .leading // Alinha os itens à esquerda
        stackView.distribution = .equalSpacing // Distribui os itens igualmente
        stackView.spacing = 8 // Define o espaçamento
        return stackView
    }()
    
    // Cria uma scroll view
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    // Função chamada quando a view é carregada
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // Define a cor de fundo da view como branco
        
        // Adiciona o scroll view à view e configura as constraints
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Centraliza horizontalmente
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Centraliza verticalmente
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9), // Define a largura como 90% da largura da view
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1) // Define a altura como 10% da altura da view
        ])
        
        // Adiciona a goalsStackView ao scroll view e configura as constraints
        scrollView.addSubview(goalsStackView)
        goalsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goalsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            goalsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            goalsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            goalsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            goalsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        // MARK: Cria um botão para abrir a modal
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        // Crie uma instância da new goal view controller modal que consegue ter navegação (NavigationController que embrulha um ViewController)
        let newGoalModalViewController = NewGoalModalViewController()
        newGoalModalViewController.delegate = self // Define o delegate
        presentModal(viewController: newGoalModalViewController) // Apresenta o modal
    }
    
    // Função chamada quando uma nova meta é adicionada
    func addedGoal(_ goal: String) {
        // Cria uma stack view (item da lista)
        let goalCheckItem = UIStackView()
        goalCheckItem.axis = .horizontal // Define a orientação da stack view como horizontal
        goalCheckItem.spacing = 8 // Define o espaçamento entre os itens
        
        // Cria o checkmark clicável
        let checkmarkButton = UIButton(type: .system)
        checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkmarkButton.addTarget(self, action: #selector(circleButtonTapped(_:)), for: .touchUpInside)
        
        // Cria o label que é o nome da meta
        let goalName = UILabel()
        goalName.text = goal
        
        // Adiciona os dois na stack view goalCheckItem
        goalCheckItem.addArrangedSubview(checkmarkButton)
        goalCheckItem.addArrangedSubview(goalName)
        
        self.goalsStackView.addArrangedSubview(goalCheckItem)
    }
    
    @objc func circleButtonTapped(_ tappedButton: UIButton) {
        if let buttonImage = tappedButton.currentImage {
            if buttonImage == UIImage(systemName: "circle") {
                tappedButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                tappedButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
}
