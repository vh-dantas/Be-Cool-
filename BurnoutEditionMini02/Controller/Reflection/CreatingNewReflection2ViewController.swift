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
    var selectedMood: String = ""
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
    
    // BarButtonItens
    var backButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
    
    // Botão para a próxima página
    let nextScreenBt = UIButton()
    
    // Variáveis da VC anterior
    var randomRefQst: String
    var randomRefAns: String
    
    // MARK: Initializer
    init(randomRefQst: String, randomRefAns: String) {
        
        self.randomRefQst = randomRefQst
        self.randomRefAns = randomRefAns
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // BarButtonItens
        backButton = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(backButtonFunc))
        cancelButton = UIBarButtonItem(title: "", image: UIImage(systemName: "xmark"), target: self, action: #selector(cancelButtonFunc))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = cancelButton
        
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - NextScreen Button
    private func setupNextScreenBt() {
        // Configurações do botão
        nextScreenBt.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextScreenBt.tintColor = UIColor.white
        nextScreenBt.configuration?.buttonSize = .large
        
        nextScreenBt.backgroundColor = .systemBlue
        nextScreenBt.layer.cornerRadius = 27.5
        
        view.addSubview(nextScreenBt)
        
        nextScreenBt.addTarget(self, action: #selector(goToScreen3), for: .touchUpInside)
    }
    
    @objc func goToScreen3() {
        
        let nextScreen = CreatingNewReflection3ViewController(selectedMood: selectedMood, randomRefQst: randomRefQst, randomRefAns: randomRefAns)
        
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - Labels
    private func setupLabels() {
        // Configurações da primeira label
        label.text = "Now tell us:"
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
        mainStackView.spacing = 70
        
        // Célula "Happy"
        happyMood.setTitle("😃", for: .normal)
        happyMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        happyMood.backgroundColor = .lightGray
        happyMood.layer.cornerRadius = 40
        happyTxt.text = "Happy"
        happyTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        happyStackView.addArrangedSubview(happyMood)
        happyStackView.addArrangedSubview(happyTxt)
        
        // Célula "Normal"
        normalMood.setTitle("😐", for: .normal)
        normalMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        normalMood.backgroundColor = .lightGray
        normalMood.layer.cornerRadius = 40
        normalTxt.text = "Normal"
        normalTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        normalStackView.addArrangedSubview(normalMood)
        normalStackView.addArrangedSubview(normalTxt)
        
        
        // Célula "Sad"
        sadMood.setTitle("😔", for: .normal)
        sadMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        sadMood.backgroundColor = .lightGray
        sadMood.layer.cornerRadius = 40
        sadTxt.text = "Sad"
        sadTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        sadStackView.addArrangedSubview(sadMood)
        sadStackView.addArrangedSubview(sadTxt)
        
        // Célula "Stressed"
        stressedMood.setTitle("😤", for: .normal)
        stressedMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        stressedMood.backgroundColor = .lightGray
        stressedMood.layer.cornerRadius = 40
        stressedTxt.text = "Stressed"
        stressedTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        stressedStackView.addArrangedSubview(stressedMood)
        stressedStackView.addArrangedSubview(stressedTxt)
        
        // Célula "Excited"
        excitedMood.setTitle("🤩", for: .normal)
        excitedMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        excitedMood.backgroundColor = .lightGray
        excitedMood.layer.cornerRadius = 40
        excitedTxt.text = "Excited"
        excitedTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        excitedStackView.addArrangedSubview(excitedMood)
        excitedStackView.addArrangedSubview(excitedTxt)
        
        // Célula "Tranquil"
        tranquilMood.setTitle("😌", for: .normal)
        tranquilMood.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        tranquilMood.backgroundColor = .lightGray
        tranquilMood.layer.cornerRadius = 40
        tranquilTxt.text = "Tranquil"
        tranquilTxt.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        tranquilStackView.addArrangedSubview(tranquilMood)
        tranquilStackView.addArrangedSubview(tranquilTxt)
        
        // Adicionando todas as stack views dentro da rightStackView
        rightStackView.addArrangedSubview(happyStackView)
        rightStackView.addArrangedSubview(normalStackView)
        rightStackView.addArrangedSubview(sadStackView)
        mainStackView.addArrangedSubview(rightStackView)
        
        // Adicionando todas as stack views dentro da leftStackView
        leftStackView.addArrangedSubview(stressedStackView)
        leftStackView.addArrangedSubview(excitedStackView)
        leftStackView.addArrangedSubview(tranquilStackView)
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
        if hasSelectedMood {
            
        } else {
            selectedMood = "😃"
            hasSelectedMood = true
            
            happyMood.backgroundColor = .systemBlue
        }
    }
    
    // Normal Mood
    @objc func normalMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😐"
            hasSelectedMood = true
            
            normalMood.backgroundColor = .systemBlue
        }
    }
    
    // Sad Mood
    @objc func sadMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😔"
            hasSelectedMood = true
            
            sadMood.backgroundColor = .systemBlue
        }
    }
    
    // Stressed Mood
    @objc func stressedMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😤"
            hasSelectedMood = true
            
            stressedMood.backgroundColor = .systemBlue
        }
    }
    
    // Excited Mood
    @objc func excitedMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "🤩"
            hasSelectedMood = true
            
            excitedMood.backgroundColor = .systemBlue
        }
    }
    
    // Tranquil Mood
    @objc func tranquilMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😌"
            hasSelectedMood = true
            
            tranquilMood.backgroundColor = .systemBlue
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
            mainStackView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: view.frame.height / 10),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        happyMood.translatesAutoresizingMaskIntoConstraints = false
        normalMood.translatesAutoresizingMaskIntoConstraints = false
        sadMood.translatesAutoresizingMaskIntoConstraints = false
        stressedMood.translatesAutoresizingMaskIntoConstraints = false
        excitedMood.translatesAutoresizingMaskIntoConstraints = false
        tranquilMood.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            happyMood.widthAnchor.constraint(equalToConstant: 80),
            happyMood.heightAnchor.constraint(equalToConstant: 80),
            
            normalMood.widthAnchor.constraint(equalToConstant: 80),
            normalMood.heightAnchor.constraint(equalToConstant: 80),
            
            sadMood.widthAnchor.constraint(equalToConstant: 80),
            sadMood.heightAnchor.constraint(equalToConstant: 80),
            
            stressedMood.widthAnchor.constraint(equalToConstant: 80),
            stressedMood.heightAnchor.constraint(equalToConstant: 80),
            
            excitedMood.widthAnchor.constraint(equalToConstant: 80),
            excitedMood.heightAnchor.constraint(equalToConstant: 80),
            
            tranquilMood.widthAnchor.constraint(equalToConstant: 80),
            tranquilMood.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // Botão NextScreen
        nextScreenBt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextScreenBt.widthAnchor.constraint(equalToConstant: 55),
            nextScreenBt.heightAnchor.constraint(equalToConstant: 55),
            nextScreenBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            nextScreenBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
    }
    
}
