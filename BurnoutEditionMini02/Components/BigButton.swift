//
//  BigButton.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 05/10/23.
//

import UIKit

class BigButton: UIView {
    let bigButton = UIButton(type: .custom)
    
    weak var delegate: BigButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true // deixa clicável
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpButton() {
        //customizando o botao de ir pra próxima tela
        let buttonSize: CGFloat = 50
        bigButton.backgroundColor = UIColor(red: 0.95, green: 0.43, blue: 0.26, alpha: 1)
        bigButton.tintColor = .white
        bigButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        bigButton.layer.cornerRadius = buttonSize / 2
        bigButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bigButton)
        
        //constraints do botao
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: buttonSize + 16),
            bigButton.widthAnchor.constraint(equalToConstant: buttonSize),
            bigButton.heightAnchor.constraint(equalToConstant: buttonSize),
            bigButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bigButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        bigButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    //reconhece que foi clicado
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Chame a função do delegado quando o gesto de toque for reconhecido
        delegate?.bigButtonTouched()
    }
}

///delegate para usar o bigbutton
protocol BigButtonDelegate: AnyObject {
    func bigButtonTouched()
}

