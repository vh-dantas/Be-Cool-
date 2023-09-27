//
//  GoalsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

// Implementa o protocolo NewGoalModalDelegate
class GoalsViewController: UIViewController, NewGoalModalDelegate {
    
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
    
    // MARK: -- Carrega a view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "goals".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white // Define a cor de fundo da view como branco
        
        view.addSubview(scrollView)
        scrollView.addSubview(goalsStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        goalsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            goalsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            goalsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            goalsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            goalsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            goalsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        // MARK: -- Botões de navegação
        let openModalBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNewGoal))
        navigationItem.rightBarButtonItem = openModalBtn
        
        let openSettingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.leftBarButtonItem = openSettingsButton
    }
    
    @objc func createNewGoal() {
        let newGoalModalViewController = NewGoalModalViewController()
        newGoalModalViewController.delegate = self // Define o delegate
        presentModal(viewController: newGoalModalViewController) // Apresenta o modal
    }
    
    @objc func openSettings() {
        let settingsModalViewController = SettingsModalViewController()
        presentModal(viewController: settingsModalViewController)
    }
    
    func addedGoal(_ goal: String) {
        navigationItem.title = goal
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
