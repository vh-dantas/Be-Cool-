//
//  NewGoalModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewGoalModalViewController: ViewController, UITextFieldDelegate, BigButtonDelegate {
    
    //Criar a home para iniciar o delegate
    let homeGoal: GoalsViewController
    
    // Cria UILabel
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    //Cria o textfield
    let bottomLineTextField = CustomLineTextField()
    
    // Cria o botão de navegação
    let bigButton = BigButton()
    
    // Cria uma stack view
    let stackView = UIStackView()
    
    //instancia da model Goal
    var goal = GoalStatic(id: UUID(), title: "")
    
    //delegate
    weak var delegate: NewGoalModalDelegate?
    
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
        
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setUpFirstLabel()
        setUpSecondLabel()
        setUpBottomLineTextField()
        setUpStackView()
        setUpBigButton()
        
    }
    
    //MARK: -- SetUp Elementos da view
    
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
        //Configura propriedades da StackView
        stackView.axis = .vertical //axis = eixo
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false //para usar as constraints
        
        //Sempre que for criar constraints tem que adicionar antes a subview
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        //adiciona como filhas da stack view
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(bottomLineTextField)
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
}

//MARK: -- Protocolos

protocol NewGoalModalDelegate: AnyObject {
    func addedGoal(_ goal: String)
}
