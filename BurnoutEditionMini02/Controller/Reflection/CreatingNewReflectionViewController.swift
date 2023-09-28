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
    let thirdLabel = UILabel()
    
    // Divider
    let divider = UIView()
    
    // Botão de salvar
    let saveReflectionBt = UIButton(type: .system)
    
    // Array de reflections
    var reflectionModels: [ReflectionModel] = []
    
    // Mensagem gerada pelo app para promover a reflexão
    var randomMessage: String = ""
    
    // Botão para PencilKit
    var drawButton = UIButton()
    
    // MARK: - TESTE
    let nextScreen = UIButton()
        
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "xmark")
        
        view.backgroundColor = .white
        
//        setupLabels()
//        setupTextFields()
//        setupCancelBt()
//        setupDrawButton()
        testeFunc()
        
    }
    
    // MARK: - BOTÃO TESTE
    private func testeFunc() {
        nextScreen.setTitle("TESTE", for: .normal)
        nextScreen.backgroundColor = .lightGray
        nextScreen.layer.cornerRadius = 5
        
        view.addSubview(nextScreen)
        
        nextScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextScreen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            nextScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            nextScreen.heightAnchor.constraint(equalToConstant: 80),
            nextScreen.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        nextScreen.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
    }
    
    @objc func goToNextScreen() {
        navigationController?.pushViewController(CreatingNewReflection2ViewController(), animated: true)
    }
    
    // MARK: - Botão para desenhar
    private func setupDrawButton() {
        drawButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        drawButton.backgroundColor = .lightGray
        drawButton.layer.cornerRadius = 5
        
        view.addSubview(drawButton)
        
        drawButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drawButton.heightAnchor.constraint(equalToConstant: 30),
            drawButton.widthAnchor.constraint(equalToConstant: 30),
            drawButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            drawButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5)
        ])
        
        drawButton.addTarget(self, action: #selector(goToCanvas), for: .touchUpInside)
    }
    
    @objc func goToCanvas() {
        navigationController?.pushViewController(ReflectionCanvasViewController(), animated: true)
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
        
        thirdLabel.text = "How are you feeling after this reflection?"
        thirdLabel.font.withSize(6)
        thirdLabel.textColor = .gray
        
        // Cor do Divider
        divider.backgroundColor = .lightGray
        
        // Adicionando à view
        view.addSubview(firstLabel)
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
            //textField.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 15),
            textField.widthAnchor.constraint(equalToConstant: screenWidth-40),
            textField.heightAnchor.constraint(equalToConstant: screenHeight/3)
        ])
        
    }
    
}
