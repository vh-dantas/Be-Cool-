//
//  GradientView.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 10/10/23.
//

import Foundation
import UIKit


class GradientView: UIView {
    let workIcon = UIImageView(image: UIImage(systemName: "briefcase.fill"))
    let lifeIcon = UIImageView(image: UIImage(systemName: "heart.fill"))
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        
        workIcon.tintColor = UIColor(named: "ScaleIcon1Color")
        lifeIcon.tintColor = UIColor(named: "ScaleIcon2Color")
        
        let iconSizeHeight: CGFloat = 18
        let iconSizeWidth: CGFloat = 20
        let yPosition = (bounds.height - iconSizeWidth) / 2
        
        workIcon.frame = CGRect(x: 10, y: yPosition, width: iconSizeWidth, height: iconSizeHeight)
        lifeIcon.frame = CGRect(x: bounds.width - iconSizeWidth - 10, y: yPosition, width: iconSizeWidth, height: iconSizeHeight)
        
        addSubview(workIcon)
        addSubview(lifeIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(named: "WorkSideScaleColor")?.cgColor ?? UIColor.cyan, UIColor(named: "WellnessSideScaleColor")?.cgColor ?? UIColor.systemMint]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        func updateGradientStartAndEndPoints(startPoint: CGPoint, endPoint: CGPoint) {
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }
        
        layer.addSublayer(gradientLayer)
        layer.cornerRadius = 13
        layer.masksToBounds = true
    }
}

