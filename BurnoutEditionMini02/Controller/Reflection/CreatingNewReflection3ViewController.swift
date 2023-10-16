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
    var suaBotaoBottomConstraint: NSLayoutConstraint!
    var botaoBottomConstantPadrao: CGFloat = 16
    
    // Variáveis da VC anterior
    var selectedMood: String?
    var randomRefQst: String?
    var randomRefAns: String?
    var imageView: UIImageView?
    var finalDrawing: UIImageView?
    
    var goal: Goal?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        // BarButtonItens
        backButton = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(backButtonFunc))
        cancelButton = UIBarButtonItem(title: "", image: UIImage(systemName: "xmark"), target: self, action: #selector(cancelButtonFunc))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = cancelButton
        
        saveButton.isHidden = true

        
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
        saveButton.setTitle("save-reflection".localized, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        saveButton.titleLabel?.textColor = UIColor(named: "LabelColor")
        saveButton.backgroundColor = UIColor(named: "AccentColor")
        saveButton.layer.cornerRadius = 25
        
        view.addSubview(saveButton)
        
        saveButton.addTarget(self, action: #selector(saveReflection), for: .touchUpInside)
        
        // Crie a constraint para o espaço entre a parte inferior do botão e a parte inferior da view
        suaBotaoBottomConstraint = saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -botaoBottomConstantPadrao)
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
    
    @objc func saveReflection() {
        // Dados
        let refName = textField.text
        let randomRefQst = randomRefQst
        let randomRefAns = randomRefAns
        let drawing = finalDrawing
        let image = imageView
        let mood = selectedMood
        
        DataAcessObject.shared.createReflection(refName: refName ?? "", mood: mood ?? "", randomRefQST: randomRefQst ?? "", randomRefANS: randomRefAns ?? "", drawing: drawing, image: image, goal: self.goal)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - TextField
    private func setupTextField() {
        textField.placeholder = "My Reflection"
        textField.borderStyle = .none
        textField.textColor = UIColor(named: "LabelColor")
        textField.autocapitalizationType = .sentences
        textField.contentVerticalAlignment = .top
        textField.delegate = self
        
        line.backgroundColor = .lightGray
        
        // Ação para o botão aparecer/desaparecer caso nao tenha texto
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        view.addSubview(textField)
        view.addSubview(line)
    }
    
    // Dismiss o teclado
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        // Verifica se o texto do textField está vazio
        if let text = textField.text, !text.isEmpty {
            // Se não estiver vazio, mostra o botão
            saveButton.isHidden = false
        } else {
            // Se estiver vazio, oculta o botão
            saveButton.isHidden = true
        }
    }
    
    // MARK: - Labels
    private func setupLabels() {
        // Configuração da primeira label
        label.text = "accordingly".localized
        label.font.withSize(6)
        label.textColor = .gray
        
        view.addSubview(label)
        
        label2.text = "reflection-title".localized
        label2.numberOfLines = 2
        label2.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        view.addSubview(label2)
    }
    
    // MARK: - Selector dos BarButtonItem
    @objc func backButtonFunc() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonFunc() {
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
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }

}


