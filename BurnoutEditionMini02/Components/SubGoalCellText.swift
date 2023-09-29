//
//  SubGoalCellText.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 29/09/23.
//

import UIKit

//celula da NewSubGoalModalViewController que tem o textField
class SubGoalCellText: UITableViewCell {
    let textField = CustomLineTextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        textField.translatesAutoresizingMaskIntoConstraints = false //sempre para usar os constraints
        textField.addSubview(contentView)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            textField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

