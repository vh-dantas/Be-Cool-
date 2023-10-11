//
//  SubgoalLevelViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 29/09/23.
//

import UIKit

class NewSubgoalLevelViewController: ViewController, BigButtonDelegate {
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
        let bigButton = BigButton()
        
        super.viewDidLoad()
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupLabels()
        setupSlider()
        setUpBigButton()
        
        func setupLabels() {
            firstLabel.translatesAutoresizingMaskIntoConstraints = false
            secondLabel.translatesAutoresizingMaskIntoConstraints = false
            
            firstLabel.text = "subgoal-level-title".localized
            firstLabel.accessibilityLabel = "subgoal-level-title".localized
            firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            firstLabel.lineBreakMode = .byWordWrapping
            firstLabel.sizeToFit()
            firstLabel.numberOfLines = 0
            
            secondLabel.text = "subgoal-level-text".localized
            secondLabel.accessibilityLabel = "subgoal-level-text".localized
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
                taskLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                taskLabel.lineBreakMode = .byWordWrapping
                taskLabel.sizeToFit()
                taskLabel.numberOfLines = 0

                self.view.addSubview(taskLabel)
                self.view.addSubview(slider)

                // define o valor dos sliders e chama a função sliderValueChanged
                slider.minimumValue = 0
                slider.maximumValue = 100
                slider.maximumTrackTintColor = UIColor(named: "SliderTrackColor")
                slider.tag = index
                slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
                // define o nível "facil" como valor default pro slider
                sliderLevels[index] = ("easy")
                Calculator.shared.savedValues[index] = 60 // define como 60 o valor default pra calculadora

                // Constraints
                slider.translatesAutoresizingMaskIntoConstraints = false
                // IF IPAD (limita o tamanho do slider no ipad)
                if UIDevice.current.userInterfaceIdiom == .pad {
                    NSLayoutConstraint.activate([
                        taskLabel.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 45),
                        taskLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
                        taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                        slider.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: -5),
                        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        slider.widthAnchor.constraint(equalToConstant: 690)
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        taskLabel.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 45),
                        taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                        taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                        
                        slider.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: -5),
                        slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                        slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
                    ])
                }
                lastView = slider
            }
        }
        
        func setUpBigButton() {
            bigButton.delegate = self
            view.addSubview(bigButton)
            let bottomConstraint = bigButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            NSLayoutConstraint.activate([
                bottomConstraint,
                bigButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bigButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            ])
            
            //adiciona acessório ao keyboard
            stickViewToKeyboard(bottomConstraint: bottomConstraint)
        }
    }
    
    ///delegate de quando aperta o botão azul grande
    func bigButtonTouched() {
        nextView()
    }
    
    // MARK: -- Função para o valor do slider
    @objc func sliderValueChanged(_ sender: CustomSlider) {
        let step: Float = 1 // Snap
        let roundedValue = round(sender.value / step) * step // Param no ponto de snap mais próximo
        
        sender.value = roundedValue // Arredonda os valores do slider
        sender.customizeThumb()
        
        let index = sender.tag
        var savedValue: Float
        var savedLevel: String
        
        if sender.value >= 0 && sender.value < 40 {
            savedValue = 60
            savedLevel = "easy"
        } else if sender.value >= 40 && sender.value < 70 {
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
        thumbLayer.backgroundColor = UIColor(named: "SliderThumbColor")?.cgColor // cor da cápsula
        
        // Define o visual do slider de acordo com o valor:
        let label = UILabel(frame: thumbLayer.bounds)
        if self.value < 40 {
            label.text = "easy".localized
            self.minimumTrackTintColor = UIColor(named: "SliderEasyColor")
        } else if self.value >= 40 && self.value < 70 {
            label.text = "medium".localized
            self.minimumTrackTintColor = UIColor(named: "SliderMediumColor")
        } else {
            label.text = "hard".localized
            self.minimumTrackTintColor = UIColor(named: "SliderHardColor")
        }
        
        label.textAlignment = .center
        label.textColor = UIColor(named: "LabelColor") // cor da label no slider
        
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

