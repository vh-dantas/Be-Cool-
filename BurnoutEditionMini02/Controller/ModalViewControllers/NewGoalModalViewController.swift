//
//  NewGoalModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewGoalModalViewController: ViewController {
    
    //Criar a home para iniciar o delegate
    let homeGoal: GoalsViewController
    
    // Cria um UILabel
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    //Cria o textfield
    let bottomLineTextField = CustomLineTextField()
    
    // Cria o botao de adicionar a meta
    let addButton = UIButton(type: .custom)
    
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
        view.backgroundColor = .white
        
        // Configura propriedades do UILabel
        firstLabel.text = "Definindo seu objetivo profissional"
        firstLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        firstLabel.lineBreakMode = .byWordWrapping
        firstLabel.sizeToFit()
        firstLabel.numberOfLines = 0
        
        secondLabel.text = "Comece com uma meta clara e de curto prazo!"
        secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        secondLabel.lineBreakMode = .byWordWrapping
        secondLabel.sizeToFit()
        secondLabel.numberOfLines = 0
        
        //configura propriedades do textfield
        bottomLineTextField.placeholder = "Digite alguma coisa"
        bottomLineTextField.textAlignment = .left
        bottomLineTextField.maxLength = 30  //numero maximo de caracteres
        bottomLineTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged) // o que acontece quando digita
        
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
        
        //customizando o botao de ir pra próxima tela
        let buttonSize: CGFloat = 50
        addButton.backgroundColor = .systemBlue
        addButton.tintColor = .white
        addButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        addButton.layer.cornerRadius = buttonSize / 2
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)  //ação de quando clica no botão
        view.addSubview(addButton)
        //constraints do botao
        let addButtonBottomConstraint = addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: buttonSize),
            addButton.heightAnchor.constraint(equalToConstant: buttonSize),
            addButtonBottomConstraint,
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        //adiciona acessório ao keyboard
        stickViewToKeyboard(bottomConstraint: addButtonBottomConstraint)
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
}

protocol NewGoalModalDelegate: AnyObject {
    func addedGoal(_ goal: String)
}
