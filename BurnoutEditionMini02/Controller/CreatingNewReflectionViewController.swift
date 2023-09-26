//
//  CreatingNewReflectionViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import UIKit

class CreatingNewReflectionViewController: UIViewController {
    
    var textField: UITextField = UITextField()
    //var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Escondendo botão "back"
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        self.title = "New Reflection"
        
        setupTextFields()
        setupMoodTracker()
        setupLabels()
    }
    
    // MARK: - Labels
    private func setupLabels() {
        // Criação e posicionamento das labels
    }
    
    
    // MARK: - TextField
    private func setupTextFields() {
        // Configurações básicas do Text Field
        textField.placeholder = "Reflita"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.autocapitalizationType = .sentences
        textField.contentVerticalAlignment = .top
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        
        // Constraints
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            textField.widthAnchor.constraint(equalToConstant: screenWidth-40),
            textField.heightAnchor.constraint(equalToConstant: screenHeight/3)
        ])
        
    }
    
    // MARK: - Mood Tracker
    
    let happyTxt = UILabel()
    let normalTxt = UILabel()
    let sadTxt = UILabel()
    let stressedTxt = UILabel()
    let excitedTxt = UILabel()
    
    private func setupMoodTracker() {
        
        // StackViews
        let happyStackView = UIStackView()
        let normalStackView = UIStackView()
        let sadStackView = UIStackView()
        let stressedStackView = UIStackView()
        let excitedStackView = UIStackView()
        
        let mainStackView = UIStackView()
        
        // Configuração das StackViews
        happyStackView.axis = .vertical
        happyStackView.alignment = .center
        happyStackView.spacing = 1
        
        normalStackView.axis = .vertical
        normalStackView.alignment = .center
        normalStackView.spacing = 1
        
        sadStackView.axis = .vertical
        sadStackView.alignment = .center
        sadStackView.spacing = 1
        
        stressedStackView.axis = .vertical
        stressedStackView.alignment = .center
        stressedStackView.spacing = 1
        
        excitedStackView.axis = .vertical
        excitedStackView.alignment = .center
        excitedStackView.spacing = 1
        
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 18
        
        // Célula "Happy"
        let happyMood = UIButton()
        
        happyMood.setTitle("😃", for: .normal)
        happyMood.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        happyTxt.text = "Happy"
        happyTxt.font = UIFont.systemFont(ofSize: 12)
        
        happyStackView.addArrangedSubview(happyMood)
        happyStackView.addArrangedSubview(happyTxt)
        
        // Célula "Normal"
        let normalMood = UIButton()
        
        normalMood.setTitle("😐", for: .normal)
        normalMood.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        normalTxt.text = "Normal"
        normalTxt.font = UIFont.systemFont(ofSize: 12)
        
        normalStackView.addArrangedSubview(normalMood)
        normalStackView.addArrangedSubview(normalTxt)
        
        
        // Célula "Sad"
        let sadMood = UIButton()
        
        sadMood.setTitle("😔", for: .normal)
        sadMood.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        sadTxt.text = "Sad"
        sadTxt.font = UIFont.systemFont(ofSize: 12)
        
        sadStackView.addArrangedSubview(sadMood)
        sadStackView.addArrangedSubview(sadTxt)
        
        // Célula "Stressed"
        let stressedMood = UIButton()
        
        stressedMood.setTitle("😤", for: .normal)
        stressedMood.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        stressedTxt.text = "Stressed"
        stressedTxt.font = UIFont.systemFont(ofSize: 12)
        
        stressedStackView.addArrangedSubview(stressedMood)
        stressedStackView.addArrangedSubview(stressedTxt)
        
        // Célula "Excited"
        let excitedMood = UIButton()
        
        excitedMood.setTitle("🤩", for: .normal)
        excitedMood.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        excitedTxt.text = "Excited"
        excitedTxt.font = UIFont.systemFont(ofSize: 12)
        
        excitedStackView.addArrangedSubview(excitedMood)
        excitedStackView.addArrangedSubview(excitedTxt)
        
        // Adicionando todas as stack views dentro da principal
        mainStackView.addArrangedSubview(happyStackView)
        mainStackView.addArrangedSubview(normalStackView)
        mainStackView.addArrangedSubview(sadStackView)
        mainStackView.addArrangedSubview(stressedStackView)
        mainStackView.addArrangedSubview(excitedStackView)
        view.addSubview(mainStackView)
        
        // Constraints
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10)
        ])
        
        // Funcionalidade dos botões
//        happyMood.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
//        normalMood.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
//        sadMood.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
//        stressedMood.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
//        excitedMood.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        
    }
    
//    let reflectionModel: ReflectionModel = ReflectionModel(id: <#T##UUID#>, title: <#T##String#>, reflection: <#T##String#>, mood: <#T##String#>)
//
//    @objc func happyMood() {
//
//    }
//
//    @objc func normalMood() {
//
//    }
//
//    @objc func sadMood() {
//
//    }
//
//    @objc func stressedMood() {
//
//    }
//
//    @objc func excitedMood() {
//
//    }
    
    
}
