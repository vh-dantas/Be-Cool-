//
//  AddSubGoalCell.swift
//  BurnoutEditionMini02
//
//  Created by Mirelle Sine on 28/09/23.
//

import UIKit

//celula da NewSubGoalModalViewController que tem escrito checklist de tarefas
class AddSubGoalCell: UITableViewCell {
    let label = UILabel()
    let button = UIButton()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        stackView.translatesAutoresizingMaskIntoConstraints = false //sempre para usar os constraints
        stackView.axis = .horizontal //eixo horixonal
        //adiciona a stackview
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        //view dentro da celula que tem todo o conteudo
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
