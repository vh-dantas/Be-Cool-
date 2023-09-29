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
    let label1 = UILabel()
    let label2 = UILabel()
    
    // Mensagem gerada pelo app para promover a reflexão
    var randomRefQst: String = ""
    
    // Botão para PencilKit
    var drawButton = UIButton()
    
    // Botão para próxima tela
    let nextScreenBt = UIButton()
    
    // BarButtonItens
    var backButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
        
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        // BarButtonItens
        backButton = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(backButtonFunc))
        cancelButton = UIBarButtonItem(title: "", image: UIImage(systemName: "xmark"), target: self, action: #selector(cancelButtonFunc))
        
        // Funções setup
        setupLabels()
        setupTextFields()
        setupDrawButton()
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
        
        nextScreenBt.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
    }
    
    @objc func goToNextScreen() {
        let nextScreen = CreatingNewReflection2ViewController(randomRefQst: randomRefQst, randomRefAns: textField.text ?? "")
        
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - Botão para desenhar
    private func setupDrawButton() {
        // Configurações do botão de desenho
        drawButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        drawButton.backgroundColor = .lightGray
        drawButton.layer.cornerRadius = 5
        
        view.addSubview(drawButton)
        drawButton.addTarget(self, action: #selector(goToCanvas), for: .touchUpInside)
    }
    
    @objc func goToCanvas() {
        navigationController?.pushViewController(ReflectionCanvasViewController(), animated: true)
    }
    
    // MARK: - Gerar mensagem random
    private func generateMessage() -> String {
        // Reflexões propostas pelo app
        let message: [String] = ["What have you learned in the past two weeks?",
                                 "How good are you at the thing you were doing?",
                                 "How do you feel after accomplishing your goal?"]
        
        randomRefQst = message[Int.random(in: 0...message.count - 1)]
        
        return randomRefQst
    }
    
   
    
    // MARK: - Labels
    private func setupLabels() {
        
        // Demais labels fixas e configurações
        label1.text = "Now take a break and reflect about the following question:"
        label1.numberOfLines = 2
        label1.font.withSize(6)
        label1.textColor = .gray
        
        label2.text = generateMessage()
        label2.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label2.numberOfLines = 3
        
        // Adicionando à view
        view.addSubview(label1)
        view.addSubview(label2)
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
    }
    
    // MARK: - Labels
    private func constraints() {
        // Label 1
        label1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Label 2
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor),
            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // TextField
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 15),
            textField.widthAnchor.constraint(equalToConstant: screenWidth-40),
            textField.heightAnchor.constraint(equalToConstant: screenHeight/3)
        ])
        
        // Botão para desenhar
        drawButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drawButton.heightAnchor.constraint(equalToConstant: 30),
            drawButton.widthAnchor.constraint(equalToConstant: 30),
            drawButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            drawButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5)
        ])
        
        // NextScreen Button
        nextScreenBt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextScreenBt.widthAnchor.constraint(equalToConstant: 55),
            nextScreenBt.heightAnchor.constraint(equalToConstant: 55),
            nextScreenBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            nextScreenBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
    }
    
}
