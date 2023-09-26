//
//  CreatingNewReflectionViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import UIKit

class CreatingNewReflectionViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Variáveis
    // TextField
    var textField: UITextField = UITextField()
    
    // Labels
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    let thirdLabel = UILabel()
    
    // Mood Tracker
    let happyTxt = UILabel()
    let normalTxt = UILabel()
    let sadTxt = UILabel()
    let stressedTxt = UILabel()
    let excitedTxt = UILabel()
    
    // Mood (emoji) selecionado pelo usuário na Reflection
    var selectedMood: String?
    var hasSelectedMood: Bool = false
    
    // Mood StackView
    let mainStackView = UIStackView()
    
    // Divider
    let divider = UIView()
    
    // Botão de salvar
    let saveReflectionBt = UIButton(type: .system)
    
    // Array de reflections
    var reflectionModels: [ReflectionModel] = []
    
    // Mensagem gerada pelo app para promover a reflexão
    var randomMessage: String = ""
        
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Escondendo botão "back"
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        self.title = "New Reflection"
        
        setupLabels()
        setupTextFields()
        setupMoodTracker()
        setupSaveButton()
        setupCancelBt()
        
    }
    
    // MARK: - Botão de cancelar
    private func setupCancelBt() {
        let cancelBt = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelReflection))
        navigationItem.rightBarButtonItem = cancelBt
    }
    
    @objc private func cancelReflection() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Gerar mensagem random
    private func generateMessage() -> String {
        // Reflexões propostas pelo app
        let message: [String] = ["What have you learned in the past two weeks?",
                                 "How good are you at the thing you were doing?",
                                 "How do you feel after accomplishing your goal?"]
        
        randomMessage = message[Int.random(in: 0...message.count - 1)]
        
        return randomMessage
    }
    
    // MARK: - Botão de salvar
    private func setupSaveButton() {
        saveReflectionBt.setTitle("Salvar", for: .normal)
        saveReflectionBt.tintColor = .white
        saveReflectionBt.backgroundColor = .systemBlue
        saveReflectionBt.layer.cornerRadius = 15
        
        view.addSubview(saveReflectionBt)
        
        saveReflectionBt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveReflectionBt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveReflectionBt.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 25),
            saveReflectionBt.widthAnchor.constraint(equalToConstant: view.frame.width / 5),
            saveReflectionBt.heightAnchor.constraint(equalToConstant: view.frame.height / 25)
        ])
        
        saveReflectionBt.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        
        guard let textRef = textField.text, !textRef.isEmpty else {
            // Exibir mensagem de erro: Campo de Reflection vazio
            return
        }
        
        let id = getID()
        let reflection = randomMessage
        let text = textRef
        let mood = selectedMood ?? ""
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        
        let newReflection = ReflectionModel(id: id, reflection: reflection, text: text, mood: mood, date: formattedDate)
        
        reflectionModels.append(newReflection)
        
        print(newReflection.description)
        
        navigationController?.popToRootViewController(animated: true)
        //let alert = UIAlertController(title: "Good Reflection!", message: "Your reflection has been saved succesfully.", preferredStyle: .alert)
        
    }
    
    // MARK: - ID
    private func getID() -> UUID{
        let id = UUID()
        return id
    }
    
    // MARK: - Labels and Divider
    private func setupLabels() {
        
        // Label da mensagem gerada e configurações
        let randomMessageLabel = UILabel()
        randomMessageLabel.text = generateMessage()
        randomMessageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        randomMessageLabel.numberOfLines = 3
        
        // Demais labels fixas e configurações
        firstLabel.text = "Now take a break and reflect about the following question:"
        firstLabel.numberOfLines = 2
        firstLabel.font.withSize(6)
        firstLabel.textColor = .gray
        secondLabel.text = "Write here your reflection:"
        secondLabel.font.withSize(6)
        secondLabel.textColor = .gray
        thirdLabel.text = "How are you feeling after this reflection?"
        thirdLabel.font.withSize(6)
        thirdLabel.textColor = .gray
        
        // Cor do Divider
        divider.backgroundColor = .lightGray
        
        // Adicionando à view
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdLabel)
        
        view.addSubview(randomMessageLabel)
        
        view.addSubview(divider)
        
        // Constraints
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15),
            firstLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            firstLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            secondLabel.topAnchor.constraint(equalTo: randomMessageLabel.bottomAnchor, constant: 15)
        ])
        
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 325)
        ])
        
        randomMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            randomMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomMessageLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            randomMessageLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 15)
        ])
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalToConstant: view.frame.width),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)
        ])
        
    }
    
    
    // MARK: - TextField
    private func setupTextFields() {
        
        // Configurações básicas do Text Field
        textField.placeholder = "Reflect..."
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.autocapitalizationType = .sentences
        textField.contentVerticalAlignment = .top
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        
        // Constraints
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 15),
            textField.widthAnchor.constraint(equalToConstant: screenWidth-40),
            textField.heightAnchor.constraint(equalToConstant: screenHeight/3)
        ])
        
    }
    
    // MARK: - Mood Tracker
    private func setupMoodTracker() {
        
        // StackViews
        let happyStackView = UIStackView()
        let normalStackView = UIStackView()
        let sadStackView = UIStackView()
        let stressedStackView = UIStackView()
        let excitedStackView = UIStackView()
        
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
            mainStackView.topAnchor.constraint(equalTo: thirdLabel.bottomAnchor, constant: 10)
        ])
        
        //Funcionalidade dos botões
        happyMood.addTarget(self, action: #selector(happyMoodFunc), for: .touchUpInside)
        normalMood.addTarget(self, action: #selector(normalMoodFunc), for: .touchUpInside)
        sadMood.addTarget(self, action: #selector(sadMoodFunc), for: .touchUpInside)
        stressedMood.addTarget(self, action: #selector(stressedMoodFunc), for: .touchUpInside)
        excitedMood.addTarget(self, action: #selector(excitedMoodFunc), for: .touchUpInside)
        
    }
    
    // MARK: - TO-DO: Feedback visual de qual mood foi escolhido.
    @objc func happyMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😃"
            hasSelectedMood = true
        }
        
    }
    
    @objc func normalMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😐"
            hasSelectedMood = true
        }        }
    
    @objc func sadMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😔"
            hasSelectedMood = true
        }        }
    
    @objc func stressedMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "😤"
            hasSelectedMood = true
        }        }
    
    @objc func excitedMoodFunc() {
        if hasSelectedMood {
            
        } else {
            selectedMood = "🤩"
            hasSelectedMood = true
        }
        
    }
    
}
