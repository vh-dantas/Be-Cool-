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
    let rectangleView = UIView()
    let shape = CAShapeLayer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(rectangleView)
        contentView.addSubview(customLabel)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            customLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 10),
            customLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            rectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rectangleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rectangleView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Set the corner radius for the right side corners
        let maskPath = UIBezierPath(roundedRect: rectangleView.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 20, height: 20))
        
        shape.path = maskPath.cgPath
        rectangleView.layer.mask = shape
    }
}
