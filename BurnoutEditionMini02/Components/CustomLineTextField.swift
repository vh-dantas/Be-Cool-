//
//  CustomLineTextField.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 28/09/23.
//

import UIKit

//text field customizado
class CustomLineTextField: UITextField {
    
    //divider
    private let bottomLine = UIView()
    
    //contador de characteres
    private let characterCountLabel = UILabel()
    
    //tamanho máximo da label
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
    
    // É chamada quando a view vai ser atualizada
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //variavel que deixa mais bonito no eixo y
        let ySpacing = frame.height + 8
        
        bottomLine.frame = CGRect(x: 0, y: ySpacing, width: frame.width, height: 1)
        
        let countLabelWidth: CGFloat = 40
        let countLabelHeight: CGFloat = 20
        characterCountLabel.frame = CGRect(x: 0, y: ySpacing, width: countLabelWidth, height: countLabelHeight)
    }
    
    //conta os caracteres
    func count() {
        guard let maxLength = maxLength else { return }
        let currentCount = text?.count ?? 0
        characterCountLabel.text = "\(currentCount)/\(maxLength)"
    }
    
    //função chamada para resetar o count quando muda de view
    func reset() {
        text = ""
        count()
    }
}
