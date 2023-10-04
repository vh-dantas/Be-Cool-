//
//  SubgoalLevelViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 29/09/23.
//

import UIKit

class NewSubgoalLevelViewController: UIViewController {
    var sliderLevels: [Int: String] = [:]
    
    init() {
        // Sempre chamar este super.init
        super.init(nibName: nil, bundle: nil)
        CreateGoalVCStore.shared.subgoalLevelViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let firstLabel = UILabel()
        let secondLabel = UILabel()
        let addButton = UIButton(type: .system)
        
        super.viewDidLoad()
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = .white
        setupLabels()
        setupSlider()
        setupNextButton()
        
        func setupLabels() {
            firstLabel.translatesAutoresizingMaskIntoConstraints = false
            secondLabel.translatesAutoresizingMaskIntoConstraints = false
            
            firstLabel.text = "subgoal-level-title".localized
            firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            firstLabel.lineBreakMode = .byWordWrapping
            firstLabel.sizeToFit()
            firstLabel.numberOfLines = 0
            
            secondLabel.text = "subgoal-level-text".localized
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
        
        // MARK: -- SLIDER
        func setupSlider() {
            let subGoals = CreateGoalVCStore.shared.newSubGoalModalViewController?.subGoals ?? []
            var lastView: UIView = secondLabel

            for (index, subGoal) in subGoals.enumerated() {
                let slider = CustomSlider()
                let taskLabel = UILabel()

                // cria a label com o nome da task
                taskLabel.translatesAutoresizingMaskIntoConstraints = false
                taskLabel.text = subGoal.title
                taskLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
                taskLabel.lineBreakMode = .byWordWrapping
                taskLabel.sizeToFit()
                taskLabel.numberOfLines = 0

                self.view.addSubview(taskLabel)
                self.view.addSubview(slider)

                // define o valor dos sliders e chama a função sliderValueChanged
                slider.minimumValue = 0
                slider.maximumValue = 100
                slider.tag = index
                slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
                // define o nível "facil" como valor default pro slider
                sliderLevels[index] = ("easy")
                Calculator.shared.savedValues[index] = 60

                // Constraints pra label
                NSLayoutConstraint.activate([
                    taskLabel.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 45),
                    taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                ])

                // Constraints pro slider
                slider.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    slider.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: -5),
                    slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                    slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
                ])

                lastView = slider
            }
        }

        
        func setupNextButton() {
            //cria um conteiner para adicionar o botao dentro
            let addButtonContainer = UIView()
            addButtonContainer.isUserInteractionEnabled = true // deixa clicável
            addButtonContainer.translatesAutoresizingMaskIntoConstraints = false  //deixa setar as constraints
            view.addSubview(addButtonContainer)
            
            //customizando o botao de ir pra próxima tela
            let buttonSize: CGFloat = 50
            addButton.backgroundColor = .systemBlue
            addButton.tintColor = .white
            addButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            addButton.layer.cornerRadius = buttonSize / 2
            addButton.translatesAutoresizingMaskIntoConstraints = false
            addButton.addTarget(self, action: #selector(nextView), for: .touchUpInside)  //ação de quando clica no botão
            addButtonContainer.addSubview(addButton)
            //constraints do botao
            NSLayoutConstraint.activate([
                addButtonContainer.heightAnchor.constraint(equalToConstant: buttonSize + 16),
                addButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                addButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                addButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                addButton.widthAnchor.constraint(equalToConstant: buttonSize),
                addButton.heightAnchor.constraint(equalToConstant: buttonSize),
                addButton.bottomAnchor.constraint(equalTo: addButtonContainer.bottomAnchor, constant: -16),
                addButton.trailingAnchor.constraint(equalTo: addButtonContainer.trailingAnchor, constant: -16)
            ])
        }
    }
    
    // MARK: -- Função para o valor do slider
    @objc func sliderValueChanged(_ sender: CustomSlider) {
        let step: Float = 50 // Snap
        let roundedValue = round(sender.value / step) * step // Param no ponto de snap mais próximo
        
        sender.value = roundedValue // Arredonda os valores do slider
        sender.customizeThumb()
        
        let index = sender.tag
        var savedValue: Float
        var savedLevel: String
        
        if sender.value >= 0 && sender.value < 50 {
            savedValue = 60
            savedLevel = "easy"
        } else if sender.value >= 50 && sender.value < 100 {
            savedValue = 150
            savedLevel = "medium"
        } else { // sender.value = 100
            savedValue = 180
            savedLevel = "hard"
        }
        
        
        CreateGoalVCStore.shared.subgoalLevelViewController?.sliderLevels[index] = savedLevel
        Calculator.shared.savedValues[index] = savedValue
    }
    
    @objc func nextView() {
        // cria a navegacao de push entre as telas
        let newWellnessSubgoalsModalViewController = NewWellnessSubgoalsModalViewController()
        navigationController?.pushViewController(newWellnessSubgoalsModalViewController, animated: true)
    }
}



// MARK: -- SLIDER CUSTOMIZADO
class CustomSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeThumb()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeThumb()
    }
    
    // Customiza a bolinha do slider:
    func customizeThumb() {
        let thumbLayer = CALayer()
        thumbLayer.bounds = CGRect(x: 0, y: 0, width: 130, height: 35) // ajuste do tamanho da thumb
        thumbLayer.cornerRadius = thumbLayer.bounds.height / 2 // cria o formato de cápsula
        thumbLayer.backgroundColor = UIColor.lightGray.cgColor // cor da cápsula
        
        // Define o visual do slider de acordo com o valor:
        let label = UILabel(frame: thumbLayer.bounds)
        if self.value < 50 {
            label.text = "easy".localized
            self.minimumTrackTintColor = UIColor.lightGray
        } else if self.value == 50 {
            label.text = "medium".localized
            self.minimumTrackTintColor = UIColor.gray
        } else {
            label.text = "hard".localized
            self.minimumTrackTintColor = UIColor.darkGray
        }
        
        label.textAlignment = .center
        label.textColor = .black // cor da label no slider
        
        // Adiciona a label em uma "imagem"
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            label.layer.render(in: currentContext)
            let labelImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Marca a thumb/cápsula como a imagem em que a label vai ser adicionada
            thumbLayer.contents = labelImage?.cgImage
        }
        
        let thumbImage = UIGraphicsImageRenderer(bounds: thumbLayer.bounds).image { _ in
            thumbLayer.render(in: UIGraphicsGetCurrentContext()!)
        }
        self.setThumbImage(thumbImage, for: .normal)
    }
    
    // Customiza o trilho do slider
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 35
        return rect
    }
}

// MARK: Calcula o valor necessário de bem-estar
class Calculator {
    static let shared = Calculator()
    var savedValues: [Int: Float] = [:]
    let balance: Float = 0.3

    func calculateResult() -> (Int, Int) {
        var sum: Float = 0
        for value in savedValues.values {
            sum += value
        }
        print("total de horas de trabalho em minutos: \(sum)")
        let resultMinutes = (sum * balance)
        let roundedResultMinutes = round(resultMinutes)
        print("total de horas de bem-estar em minutos: \(resultMinutes)")
        let hours = Int(roundedResultMinutes) / 60
        let minutes = Int(roundedResultMinutes) % 60
        print("horas de bem-estar recomendadas: \(hours) hora(s) e \(minutes) minutos")
        return (hours, minutes)
    }
}
