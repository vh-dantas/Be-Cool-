//
//  NewGoalModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewGoalModalViewController: UIViewController {
    
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
    var goals = [GoalStatic]()
    
    //delegate
    weak var delegate: NewGoalModalDelegate?
    
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
        bottomLineTextField.maxLength = 50  //numero maximo de caracteres
        //bottomLineTextField.frame = CGRect(x: 50, y: 100, width: 200, height: 30)
        bottomLineTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged) // o que acontece quando digita

        
        //Configura propriedades do UIButton
        if let image = UIImage(named: "button") {
        addButton.setImage(image, for: .normal)
        }
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside) // o que acontece quando clica no botao
        
        //Configura propriedades da StackView
        stackView.axis = .vertical //axis = eixo
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false //para usar as constraints
        
        //Sempre que for criar constraints tem que adicionar antes a subview
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        //adiciona como filhas da stack view
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(bottomLineTextField)
        stackView.addArrangedSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 1000),
            //addButton.
        ])
    }
    
    @objc func addTask() {
        if let goalText = bottomLineTextField.text, !goalText.isEmpty {
            delegate?.addedGoal(goalText)
            let goal = GoalStatic(id: UUID(), title: goalText)
            goals.append(goal)
            bottomLineTextField.text = ""
            
            // cria a navegacao de push entre as modais
            let newSubGoalModalViewController = NewSubgoalsModalViewController(goals: goals)
            navigationController?.pushViewController(newSubGoalModalViewController, animated: true)
            
            
        }
    }
    
    @objc func textFieldDidChange( textField: UITextField) {
        if let customLineTextField = textField as? CustomLineTextField {
            customLineTextField.contador()
        }
    }
}

class CustomLineTextField: UITextField {
    
    //divider
    private let bottomLine = UIView()
    //contador de characteres
    private let characterCountLabel = UILabel()
    
    //tamanho maxima da label
    var maxLength: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        
        bottomLine.backgroundColor = .secondaryLabel
        addSubview(bottomLine)
        
        characterCountLabel.textAlignment = .left
        characterCountLabel.textColor = .gray
        characterCountLabel.font = UIFont.systemFont(ofSize: 17)
        addSubview(characterCountLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        
        let countLabelWidth: CGFloat = 40
        let countLabelHeight: CGFloat = 20
        characterCountLabel.frame = CGRect(x: frame.width - countLabelWidth, y: frame.height, width: countLabelWidth, height: countLabelHeight)
    }
    
    func contador() {
        guard let maxLength = maxLength else { return }
        let currentCount = text?.count ?? 0
        characterCountLabel.text = "\(currentCount)/\(maxLength)"
    }
}

protocol NewGoalModalDelegate: AnyObject {
    func addedGoal(_ goal: String)
}
