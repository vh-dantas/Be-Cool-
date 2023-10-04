//
//  NewWellnessSubgoalsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewWellnessSubgoalsModalViewController: UIViewController {
    
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Só testando os valores da view anterior
        let sliderValues = CreateGoalVCStore.shared.sliderValues
        let subGoals = CreateGoalVCStore.shared.subGoals ?? []
        
        for index in subGoals.indices {
            if let value = sliderValues[index] {
                let (savedValue, savedLevel) = value
                
                if index < subGoals.count {
                    let subGoal = subGoals[index]
                    print("Index: \(index), Task: \(subGoal.title), Saved Value: \(savedValue), Saved Leve: \(savedLevel)")
                }
            }
        }
        
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = .white
        setupLabels()
        setupTimeCard()
        setupWellnessList()
        setupSaveButton()
        
        
        func setupLabels() {
            firstLabel.translatesAutoresizingMaskIntoConstraints = false
            secondLabel.translatesAutoresizingMaskIntoConstraints = false

            firstLabel.text = "wellness-subgoal-title".localized
            firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            firstLabel.lineBreakMode = .byWordWrapping
            firstLabel.sizeToFit()
            firstLabel.numberOfLines = 0
            
            secondLabel.text = "wellness-subgoal-text".localized
            secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
            secondLabel.lineBreakMode = .byWordWrapping
            secondLabel.sizeToFit()
            secondLabel.numberOfLines = 0
            
            self.view.addSubview(firstLabel)
            self.view.addSubview(secondLabel)
            
            // Constraints
            NSLayoutConstraint.activate([
                firstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
            
            NSLayoutConstraint.activate([
                secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
                secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        }
        
        
        // MARK: -- TIME CARD
        func setupTimeCard() {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false

            for index in 0..<4 {
                // Cria um retângulo com as dimensões e posição certas
                let rectangle = UIView()
                rectangle.backgroundColor = UIColor.lightGray
                rectangle.layer.cornerRadius = 5
                rectangle.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    rectangle.widthAnchor.constraint(equalToConstant: 55),
                    rectangle.heightAnchor.constraint(equalToConstant: 70)
                ])

                // Cria a label do cartão
                let timeDigit = UILabel()
                timeDigit.text = "\(index + 1)" // TODO: DEFINIR A LÓGICA DAS LABELS AQUI
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

            self.view.addSubview(stackView)

            // Constraints
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 40),
            ])
        }

        
        func setupWellnessList() {
            // TODO: Adicionar a lista de submetas
        }
        
        func setupSaveButton() {
            let saveButton = UIButton(type: .system)
            saveButton.setTitle("save-goals-btn".localized, for: .normal)
            saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            saveButton.backgroundColor = UIColor.systemBlue
            saveButton.setTitleColor(UIColor.white, for: .normal)
            saveButton.layer.cornerRadius = 25
            saveButton.translatesAutoresizingMaskIntoConstraints = false

            // Adjust the button's size to fit the text and add padding
            saveButton.titleLabel?.sizeToFit()
            let titleWidth = saveButton.titleLabel?.frame.width ?? 0
            let buttonWidth = titleWidth + 40 // Add 20 points of padding on both sides
            NSLayoutConstraint.activate([
                saveButton.widthAnchor.constraint(equalToConstant: buttonWidth),
                saveButton.heightAnchor.constraint(equalToConstant: 50)
            ])

            self.view.addSubview(saveButton)

            NSLayoutConstraint.activate([
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            ])
        }
    }
    
    func createGoal() {
        guard let goal = CreateGoalVCStore.shared.newGoalModalViewController?.goal, let subGoals = CreateGoalVCStore.shared.newSubGoalModalViewController?.subGoals else {
            return
        }
        let newGoal = DataAcessObject.shared.createGoal(title: goal.title)
        subGoals.forEach { subGoal in
            DataAcessObject.shared.createSubGoal(title: subGoal.title, type: subGoal.type.rawValue, goal: newGoal)
        }
    }
}
