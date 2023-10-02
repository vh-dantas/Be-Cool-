//
//  AddSubGoalCell.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 28/09/23.
//

import UIKit

//celula da NewSubGoalModalViewController
class AddSubGoalCell: UITableViewCell {
    let label = UILabel()
    let button = UIButton()
    let stackView = UIStackView()
    
    weak var delegate: AddSubGoalButtonDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        let buttonSize: CGFloat = 25
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = buttonSize / 2
        
        stackView.translatesAutoresizingMaskIntoConstraints = false //sempre para usar os constraints
        stackView.axis = .horizontal //eixo horixonal
        //adiciona a stackview
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        //view dentro da celula que tem todo o conteudo
        contentView.addSubview(stackView)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: buttonSize),
            button.heightAnchor.constraint(equalToConstant: buttonSize),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    //reconhece que foi clicado
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Chame a função do delegado quando o gesto de toque for reconhecido
        delegate?.addSubGoalButtonTouched()
    }
}

///delegate para adicionar as subgoals na tableview pelo botao
protocol AddSubGoalButtonDelegate: AnyObject {
    func addSubGoalButtonTouched()
}
