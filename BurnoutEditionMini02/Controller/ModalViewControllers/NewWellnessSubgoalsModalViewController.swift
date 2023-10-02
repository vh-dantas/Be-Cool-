//
//  NewWellnessSubgoalsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewWellnessSubgoalsModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = .white
        setupTimeCard()
        
        
        // MARK: -- TIME CARD
        func setupTimeCard() {
            let timeCardView = UIView()
            timeCardView.translatesAutoresizingMaskIntoConstraints = false
            
            for index in 0..<4 {
                let gap = 5 // espaço entre os cards
                let biggerGap = 10 // espaço maior
                var offset = (55 + gap) * index
                
                // Deslocamento (offset) do terceiro e quarto cartões
                if index > 1 {
                    offset += biggerGap - gap
                }
                
                // Cria um retângulo com as dimensões e posição certas
                let rectangle = UIView(frame: CGRect(x: offset, y: 0, width: 55, height: 70))
                rectangle.backgroundColor = UIColor.lightGray
                rectangle.layer.cornerRadius = 5
                
                // Cria a label do cartão
                let timeDigit = UILabel(frame: rectangle.bounds)
                timeDigit.text = "\(index + 1)" // TODO: DEFINIR A LÓGICA DAS LABELS AQUI
                timeDigit.textAlignment = .center
                timeDigit.font = UIFont.systemFont(ofSize: 40)
                
                rectangle.addSubview(timeDigit)
                timeCardView.addSubview(rectangle)
                
                // Adiciona o separador (:) entre o segundo e o terceiro cartão
                if index == 1 {
                    let separator = UILabel(frame: CGRect(x: Int(rectangle.frame.maxX), y: 0, width: 10, height: 60))
                    separator.text = ":"
                    separator.font = UIFont.systemFont(ofSize: 40)
                    separator.textAlignment = .center
                    timeCardView.addSubview(separator)
                }
            }
            self.view.addSubview(timeCardView)
            
            // Constraints
            NSLayoutConstraint.activate([
                    timeCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    timeCardView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
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
