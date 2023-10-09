//
//  AchievementComponents.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 06/10/23.
//

import UIKit


// Componente do percentual das Work Goals
class PercentualComponent: UIView{
    
    let colorView = UIView()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(frame: CGRect, color: UIColor, percentagem: Double, text: String){
        super.init(frame: frame)
        self.label.text = "\(percentagem)% \(text)"
        self.addSubview(label)
        self.addSubview(colorView)
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = 15 / 2
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 15),
            colorView.heightAnchor.constraint(equalToConstant: 15),
            // Label
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: colorView.trailingAnchor, multiplier: 0.5),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
