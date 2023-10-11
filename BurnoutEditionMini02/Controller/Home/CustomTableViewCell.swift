//
//  CustomTableViewCell.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 10/10/23.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    let customLabel = UILabel()
    let button = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customLabel)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            customLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 10),
            customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            customLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
