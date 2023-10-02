//
//  CreatingNewReflection3ViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 27/09/23.
//

import UIKit

class CreatingNewReflection3ViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Variáveis
    // Labels
    let label = UILabel()
    let label2 = UILabel()
    
    //TextField
    let textField = UITextField()
    let line = UIView()
    
    // UIBarButtonItem
    var backButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    
    //Botão de salvar
    let saveButton = UIButton()
    
    // Reflection
    var reflectionModels: [ReflectionModel] = []
    
    // Variáveis da VC anterior
    var selectedMood: String
    var randomRefQst: String
    var randomRefAns: String?
    
    
    // MARK: - Initializer
    init(selectedMood: String, randomRefQst: String, randomRefAns: String?) {
        
        self.selectedMood = selectedMood
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
        setupTextField()
        setupSaveBt()
        
        // Constraints
        constraints()
    }
    
    // MARK: - ID
    func getID() -> UUID {
        let id = UUID()
        return id
    }
    
    // MARK: - Botão de salvar
    private func setupSaveBt() {
        // Configurações do botão
        saveButton.setTitle("Save Reflection", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        saveButton.titleLabel?.textColor = .white
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 20
        
        view.addSubview(saveButton)
        
        saveButton.addTarget(self, action: #selector(saveReflection), for: .touchUpInside)
    }
    
    @objc func saveReflection() {
        // Instâncias das VC
        let getDrawing = ReflectionCanvasViewController()
        
        // Dados
        let id = getID()
        var refName = ""
        if let refNameUnwapped = textField.text {
            refName = refNameUnwapped
        }
        let randomRefQst = randomRefQst
        let randomRefAns = randomRefAns
        let drawing = getDrawing.finalDrawing
        let mood = selectedMood
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        
//        let newReflection = ReflectionModel(id: id, name: refName ?? "", relatedGoal: nil, randomRefQst: randomRefQst, randomRefAns: randomRefAns, draw: drawing, mood: mood, date: formattedDate)
        
        DataAcessObject.shared.createReflection(refName: refName, mood: mood, randomRefQST: randomRefQst, randomRefANS: randomRefAns ?? "")
        
//        reflectionModels.append(newReflection)
//        print(newReflection.description)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - TextField
    private func setupTextField() {
        textField.placeholder = "My Reflection"
        textField.borderStyle = .none
        textField.textColor = .black
        textField.autocapitalizationType = .sentences
        textField.contentVerticalAlignment = .top
        textField.delegate = self
        
        line.backgroundColor = .lightGray
        
        view.addSubview(textField)
        view.addSubview(line)
    }
    
    // MARK: - Labels
    private func setupLabels() {
        // Configuração da primeira label
        label.text = "Accordingly to what it represents to you:"
        label.font.withSize(6)
        label.textColor = .gray
        
        view.addSubview(label)
        
        label2.text = "Name your reflection."
        label2.numberOfLines = 2
        label2.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        view.addSubview(label2)
    }
    
    // MARK: - Selector dos BarButtonItem
    @objc func backButtonFunc() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonFunc() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Constraints
    private func constraints() {
        // Label 1
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Label 2
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // TextField
        textField.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 45),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: (view.frame.width/10) * 8),
            
            line.widthAnchor.constraint(equalToConstant: (view.frame.width/10) * 8.5),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Save Button
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 160),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
    }

}
