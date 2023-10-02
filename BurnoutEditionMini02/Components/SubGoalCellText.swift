//
//  SubGoalCellText.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 29/09/23.
//

import UIKit

//celula da NewSubGoalModalViewController que tem o textField
class SubGoalCellText: UITableViewCell, UITextFieldDelegate {
    let textField = UITextField()
    var subGoal: SubGoal?
    
    weak var delegate: SubGoalCellTextDelegate?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false //sempre para usar os constraints
        contentView.addSubview(textField)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            textField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.subGoalTextReturnTouched()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let subGoal else {
            return
        }
        delegate?.subGoalTextDidEndEditing(subGoal, text: text)
    }
}

protocol SubGoalCellTextDelegate: AnyObject {
    func subGoalTextReturnTouched()
    func subGoalTextDidEndEditing(_ subGoal: SubGoal, text: String)
}
