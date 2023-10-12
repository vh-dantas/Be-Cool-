//
//  CreatingNewReflection2ViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 27/09/23.
//

import UIKit

class CreatingNewReflection2ViewController: UIViewController {
    
    // MARK: - Variáveis
    // Instâncias das VC
    let ref1 = CreatingNewReflectionViewController()
    
    // Labels
    let label = UILabel()
    let label2 = UILabel()
    
    // Mood Tracker
    let happyTxt = UILabel()
    let normalTxt = UILabel()
    let sadTxt = UILabel()
    let stressedTxt = UILabel()
    let excitedTxt = UILabel()
    let tranquilTxt = UILabel()
    
    // Mood (emoji) selecionado pelo usuário na Reflection
    var selectedMood: String?
    //var moodImage: UIImageView?
    var hasSelectedMood: Bool = false
    
    // Mood StackView
    let rightStackView = UIStackView()
    let leftStackView = UIStackView()
    let mainStackView = UIStackView()
    
    var happyMood = UIButton()
    var normalMood = UIButton()
    var sadMood = UIButton()
    var stressedMood = UIButton()
    var excitedMood = UIButton()
    var tranquilMood = UIButton()
    
    var moodsArray: [UIButton] = []
        
    // BarButtonItens
    var backButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
    
    // Botão para próxima tela
    let nextScreenBt = UIButton()
    var suaBotaoBottomConstraint: NSLayoutConstraint!
    var botaoBottomConstantPadrao: CGFloat = 16
    let buttonSize: CGFloat = 50
    
    // Variáveis da VC anterior
    var randomRefQst: String?
    var randomRefAns: String?
    var imageView: UIImageView?
    var drawing: UIImageView?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // BarButtonItens
        backButton = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(backButtonFunc))
        cancelButton = UIBarButtonItem(title: "", image: UIImage(systemName: "xmark"), target: self, action: #selector(cancelButtonFunc))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = cancelButton
        
        // Botão para a próxima tela não aparece até escrever algo
        nextScreenBt.isHidden = true
        moodsArray = [happyMood, normalMood, sadMood, stressedMood, excitedMood, tranquilMood]

        // Funções setup
        setupLabels()
        setupMoodTracker()
        setupNextScreenBt()
        
        // Constraints
        constraints()
        
    }
    
    // MARK: - Selector dos BarButtonItem
    @objc func backButtonFunc() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonFunc() {
        // Mostrar um alerta ao usuário ou tomar outra ação apropriada
        let yesLabel = UILabel()
        yesLabel.textColor = .systemRed
        yesLabel.text = "Yes"
        let alertController = UIAlertController(title: "warning".localized, message: "wish-cancel".localized, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "yes".localized, style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "no".localized, style: .cancel))
        present(alertController, animated: true, completion: nil)
       
    }
    
    // MARK: - NextScreen Button
    private func setupNextScreenBt() {
        // Crie o botão
        nextScreenBt.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextScreenBt.tintColor = UIColor.white
        nextScreenBt.configuration?.buttonSize = .large
        nextScreenBt.backgroundColor = UIColor(named: "AccentColor")
        nextScreenBt.layer.cornerRadius = buttonSize / 2

        view.addSubview(nextScreenBt)
        
        nextScreenBt.addTarget(self, action: #selector(goToScreen3), for: .touchUpInside)
        
        // Crie a constraint para o espaço entre a parte inferior do botão e a parte inferior da view
        suaBotaoBottomConstraint = nextScreenBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -botaoBottomConstantPadrao)
        suaBotaoBottomConstraint.isActive = true
        
        // Registre notificações para o teclado
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoApareceu), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoDesapareceu), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func tecladoApareceu(notification: Notification) {
        if let userInfo = notification.userInfo,
           let tecladoFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            // Ajuste a constraint do botão quando o teclado aparecer
            let alturaTeclado = view.frame.maxY - tecladoFrame.minY
            suaBotaoBottomConstraint.constant = -alturaTeclado
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func tecladoDesapareceu(notification: Notification) {
        // Restaure a constraint original do botão quando o teclado desaparecer
        suaBotaoBottomConstraint.constant = -botaoBottomConstantPadrao
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func goToScreen3() {
        
        let nextScreen = CreatingNewReflection3ViewController()
        
        nextScreen.randomRefAns = self.randomRefAns
        nextScreen.randomRefQst = self.randomRefQst
        nextScreen.imageView = self.imageView
        nextScreen.finalDrawing = self.drawing
        nextScreen.selectedMood = self.selectedMood
        
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - Labels
    private func setupLabels() {
        // Configurações da primeira label
        label.text = "tell".localized
        label.font.withSize(6)
        label.textColor = .gray
        
        view.addSubview(label)
        
        // Configurações da segunda label
        label2.text = "How are you feeling after this reflection?"
        label2.numberOfLines = 2
        label2.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        view.addSubview(label2)
    }
    
    // MARK: - Mood Tracker
    private func setupMoodTracker() {
        
        // StackViews
        let happyStackView = UIStackView()
        let normalStackView = UIStackView()
        let sadStackView = UIStackView()
        let stressedStackView = UIStackView()
        let excitedStackView = UIStackView()
        let tranquilStackView = UIStackView()
        
        // Configuração das StackViews
        happyStackView.axis = .vertical
        happyStackView.alignment = .center
        happyStackView.spacing = 10
        
        normalStackView.axis = .vertical
        normalStackView.alignment = .center
        normalStackView.spacing = 10
        
        sadStackView.axis = .vertical
        sadStackView.alignment = .center
        sadStackView.spacing = 10
        
        stressedStackView.axis = .vertical
        stressedStackView.alignment = .center
        stressedStackView.spacing = 10
        
        excitedStackView.axis = .vertical
        excitedStackView.alignment = .center
        excitedStackView.spacing = 10
        
        tranquilStackView.axis = .vertical
        tranquilStackView.alignment = .center
        tranquilStackView.spacing = 10
        
        rightStackView.axis = .vertical
        rightStackView.alignment = .center
        rightStackView.spacing = 30
        
        leftStackView.axis = .vertical
        leftStackView.alignment = .center
        leftStackView.spacing = 30
        
        mainStackView.axis = .horizontal
        //mainStackView.alignment = .center
        mainStackView.spacing = 45
        
        // Célula "Sad"
        sadMood.setImage(UIImage(named: "Triste"), for: .normal)
        //sadMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        sadMood.backgroundColor = .systemGray4
        sadMood.layer.cornerRadius = 50
        sadTxt.text = "sad".localized
        sadTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        sadStackView.addArrangedSubview(sadMood)
        sadStackView.addArrangedSubview(sadTxt)
        
        // Célula "Stressed"
        stressedMood.setImage(UIImage(named: "Estressado"), for: .normal)
        //stressedMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        stressedMood.backgroundColor = .systemGray4
        stressedMood.layer.cornerRadius = 50
        stressedTxt.text = "stressed".localized
        stressedTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        stressedStackView.addArrangedSubview(stressedMood)
        stressedStackView.addArrangedSubview(stressedTxt)
        
        // Célula "Normal"
        normalMood.setImage(UIImage(named: "Normal"), for: .normal)
        //normalMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        normalMood.backgroundColor = .systemGray4
        normalMood.layer.cornerRadius = 50
        normalTxt.text = "Normal"
        normalTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        normalStackView.addArrangedSubview(normalMood)
        normalStackView.addArrangedSubview(normalTxt)
        
        // Célula "Tranquil"
        tranquilMood.setImage(UIImage(named: "Tranquilo"), for: .normal)
        //tranquilMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        tranquilMood.backgroundColor = .systemGray4
        tranquilMood.layer.cornerRadius = 50
        tranquilTxt.text = "relaxed".localized
        tranquilTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        tranquilStackView.addArrangedSubview(tranquilMood)
        tranquilStackView.addArrangedSubview(tranquilTxt)
        
        // Célula "Happy"
        happyMood.setImage(UIImage(named: "Feliz"), for: .normal)
        //happyMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        happyMood.backgroundColor = .systemGray4
        happyMood.layer.cornerRadius = 50
        happyTxt.text = "happy".localized
        happyTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        happyStackView.addArrangedSubview(happyMood)
        happyStackView.addArrangedSubview(happyTxt)
        
        // Célula "Excited"
        excitedMood.setImage(UIImage(named: "Animado"), for: .normal)
        //excitedMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        excitedMood.backgroundColor = .systemGray4
        excitedMood.layer.cornerRadius = 50
        excitedTxt.text = "excited".localized
        excitedTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        //
        excitedStackView.addArrangedSubview(excitedMood)
        excitedStackView.addArrangedSubview(excitedTxt)
        
        // Adicionando todas as stack views dentro da rightStackView
        rightStackView.addArrangedSubview(sadStackView)
        rightStackView.addArrangedSubview(normalStackView)
        rightStackView.addArrangedSubview(happyStackView)
        mainStackView.addArrangedSubview(rightStackView)
        
        // Adicionando todas as stack views dentro da leftStackView
        leftStackView.addArrangedSubview(stressedStackView)
        leftStackView.addArrangedSubview(tranquilStackView)
        leftStackView.addArrangedSubview(excitedStackView)
        mainStackView.addArrangedSubview(leftStackView)
        
        view.addSubview(mainStackView)
        
        //Funcionalidade dos botões
        happyMood.addTarget(self, action: #selector(happyMoodFunc), for: .touchUpInside)
        normalMood.addTarget(self, action: #selector(normalMoodFunc), for: .touchUpInside)
        sadMood.addTarget(self, action: #selector(sadMoodFunc), for: .touchUpInside)
        stressedMood.addTarget(self, action: #selector(stressedMoodFunc), for: .touchUpInside)
        excitedMood.addTarget(self, action: #selector(excitedMoodFunc), for: .touchUpInside)
        tranquilMood.addTarget(self, action: #selector(tranquilMoodFunc), for: .touchUpInside)
        
    }
    
    // Métodos dos botões de mood
    // Happy Mood
    @objc func happyMoodFunc() {
        nextScreenBt.isHidden = false
        if selectedMood != "Feliz" {
            selectedMood = "Feliz"
            happyMood.backgroundColor = UIColor(named: "AccentColor")
            
            for mood in moodsArray {
                if mood != happyMood {
                    mood.backgroundColor = .systemGray4
                }
            }
        } else {
            happyMood.backgroundColor = .systemGray4
        }
        
    }
    
    // Normal Mood
    @objc func normalMoodFunc() {
        nextScreenBt.isHidden = false
        if selectedMood != "Normal" {
            selectedMood = "Normal"
            normalMood.backgroundColor = UIColor(named: "AccentColor")
            
            for mood in moodsArray {
                if mood != normalMood {
                    mood.backgroundColor = .systemGray4
                }
            }
        } else {
            normalMood.backgroundColor = .systemGray4
        }
    }
    
    // Sad Mood
    @objc func sadMoodFunc() {
        nextScreenBt.isHidden = false
        if selectedMood != "Triste" {
            selectedMood = "Triste"
            sadMood.backgroundColor = UIColor(named: "AccentColor")
            
            for mood in moodsArray {
                if mood != sadMood {
                    mood.backgroundColor = .systemGray4
                }
            }
        } else {
            sadMood.backgroundColor = .systemGray4
        }
        
    }
    
    // Stressed Mood
    @objc func stressedMoodFunc() {
        nextScreenBt.isHidden = false
        if selectedMood != "Estressado" {
            selectedMood = "Estressado"
            stressedMood.backgroundColor = UIColor(named: "AccentColor")
            
            for mood in moodsArray {
                if mood != stressedMood {
                    mood.backgroundColor = .systemGray4
                }
            }
        } else {
            stressedMood.backgroundColor = .systemGray4
        }
        
    }
    
    // Excited Mood
    @objc func excitedMoodFunc() {
        nextScreenBt.isHidden = false
        if selectedMood != "Animado" {
            selectedMood = "Animado"
            excitedMood.backgroundColor = UIColor(named: "AccentColor")
            
            for mood in moodsArray {
                if mood != excitedMood {
                    mood.backgroundColor = .systemGray4
                }
            }
        } else {
            excitedMood.backgroundColor = .systemGray4
        }
        
    }
    
    // Tranquil Mood
    @objc func tranquilMoodFunc() {
        nextScreenBt.isHidden = false
        if selectedMood != "Tranquilo" {
            selectedMood = "Tranquilo"
            tranquilMood.backgroundColor = UIColor(named: "AccentColor")
            
            for mood in moodsArray {
                if mood != tranquilMood {
                    mood.backgroundColor = .systemGray4
                }
            }
        } else {
            tranquilMood.backgroundColor = .systemGray4
        }
        
    }
    
    // MARK: - Constraints
    private func constraints() {
        // Label 1
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Label 2
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // MoodTracker
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: view.frame.height / 15),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        happyMood.translatesAutoresizingMaskIntoConstraints = false
        normalMood.translatesAutoresizingMaskIntoConstraints = false
        sadMood.translatesAutoresizingMaskIntoConstraints = false
        stressedMood.translatesAutoresizingMaskIntoConstraints = false
        excitedMood.translatesAutoresizingMaskIntoConstraints = false
        tranquilMood.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            happyMood.widthAnchor.constraint(equalToConstant: 100 ),
            happyMood.heightAnchor.constraint(equalToConstant: 100),
            
            normalMood.widthAnchor.constraint(equalToConstant: 100),
            normalMood.heightAnchor.constraint(equalToConstant: 100),
            
            sadMood.widthAnchor.constraint(equalToConstant: 100),
            sadMood.heightAnchor.constraint(equalToConstant: 100),
            
            stressedMood.widthAnchor.constraint(equalToConstant: 100),
            stressedMood.heightAnchor.constraint(equalToConstant: 100),
            
            excitedMood.widthAnchor.constraint(equalToConstant: 100),
            excitedMood.heightAnchor.constraint(equalToConstant: 100),
            
            tranquilMood.widthAnchor.constraint(equalToConstant: 100),
            tranquilMood.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Botão NextScreen
        nextScreenBt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextScreenBt.widthAnchor.constraint(equalToConstant: buttonSize),
            nextScreenBt.heightAnchor.constraint(equalToConstant: buttonSize),
            nextScreenBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
}
