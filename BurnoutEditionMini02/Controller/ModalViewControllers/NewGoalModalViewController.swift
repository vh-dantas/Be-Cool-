//
//  NewGoalModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewGoalModalViewController: ViewController, UITextFieldDelegate, BigButtonDelegate {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical // Define a orientação da stack view como vertical
        stackView.alignment = .leading // Alinha os itens à esquerda
        stackView.distribution = .equalSpacing // Distribui os itens igualmente
        stackView.spacing = 8 // Define o espaçamento
        return stackView
    }()
    
    //Criar a home para iniciar o delegate
    let homeGoal: GoalsViewController
    
    // Cria UILabel
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    //Cria o textfield
    let bottomLineTextField = CustomLineTextField()
    
    // Cria o botão de navegação
    let bigButton = BigButton()
    
    //instancia da model Goal
    var goal = GoalStatic(id: UUID(), title: "")
    
    //delegate
    weak var delegate: NewGoalModalDelegate?
    
    let imageView = UIImageView(image: UIImage(named: "pinguimWork"))
    
    init(homeGoal: GoalsViewController) {
        self.homeGoal = homeGoal
        super.init(nibName: nil, bundle: nil)
        CreateGoalVCStore.shared.newGoalModalViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checa se o teclado tá aberto na tela
        NotificationCenter.default.addObserver(self, selector: #selector(myKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(myKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setUpImageView()
        setUpFirstLabel()
        setUpSecondLabel()
        setUpBottomLineTextField()
        setUpStackView()
        setUpBigButton()
        
    }
    
    //MARK: -- SetUp Elementos da view
    /// Image
    /// Image
    func setUpImageView() {
        // Configure properties of UIImageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    ///título
    func setUpFirstLabel() {
        // Configura propriedades do UILabel
        firstLabel.text = "new-goal-title".localized
        firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        firstLabel.lineBreakMode = .byWordWrapping
        firstLabel.sizeToFit()
        firstLabel.numberOfLines = 0
    }
    
    ///subtítulo
    func setUpSecondLabel() {
        secondLabel.text = "new-goal-text".localized
        secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        secondLabel.lineBreakMode = .byWordWrapping
        secondLabel.sizeToFit()
        secondLabel.numberOfLines = 0
    }
    
    ///textField
    func setUpBottomLineTextField() {
        //configura propriedades do textfield
        bottomLineTextField.placeholder = "textfield-placeholder".localized
        bottomLineTextField.textAlignment = .left
        bottomLineTextField.maxLength = 30  //numero maximo de caracteres
        bottomLineTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged) // o que acontece quando digita
        
        //implemetando delegate do textField
        bottomLineTextField.delegate = self
    }
    
    ///stackView
    func setUpStackView() {
        view.addSubview(scrollView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false //para usar as constraints
        scrollView.translatesAutoresizingMaskIntoConstraints = false //para usar as constraints
        
        let safeArea = view.safeAreaLayoutGuide
        
        //Sempre que for criar constraints tem que adicionar antes a subview
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        
        
        //adiciona como filhas da stack view
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(bottomLineTextField)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            
            bottomLineTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            bottomLineTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
    
    ///big button azul
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
    
    //MARK: -- Funcionalidades
    func bigButtonTouched() {
        addTask()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        bottomLineTextField.resignFirstResponder()
    }
    
    @objc func addTask() {
        if let goalText = bottomLineTextField.text, !goalText.isEmpty {
            goal.title = goalText
            bottomLineTextField.reset()
            
            // cria a navegacao de push entre as telas
            let newSubGoalModalViewController = NewSubgoalsModalViewController()
            navigationController?.pushViewController(newSubGoalModalViewController, animated: true)
            newSubGoalModalViewController.delegate = homeGoal
            delegate?.addedGoal(goalText)
        }
    }
    
    //atualiza o textField
    @objc func textFieldDidChange( textField: UITextField) {
        if let customLineTextField = textField as? CustomLineTextField {
            customLineTextField.count()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Verifique o comprimento atual do texto no campo
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Verifique se a nova string excede o limite máximo
        if newText.count > (bottomLineTextField.maxLength ?? 30) {
            return false // Não permita a adição de mais caracteres
        }
        
        // Se a nova string não exceder o limite, permita a alteração
        return true
    }
    
    // Pega o tamanho da altura do teclado e adiciona na altura da scroll view pra permitir o scroll quando o teclado estiver visível
    @objc func myKeyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 25, right: 0)
        }
    }
    
    @objc func myKeyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    // Desinicializa o observer do teclado
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

//MARK: -- Protocolos

protocol NewGoalModalDelegate: AnyObject {
    func addedGoal(_ goal: String)
}
