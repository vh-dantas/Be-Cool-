//
//  BreathAnimationViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import UIKit

class BreathAnimationViewController: UIViewController, CAAnimationDelegate {
    
    // Criando a layer da animação
    let animLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Esconder NavBar Itens
        self.navigationItem.hidesBackButton = true
        
        // Cor de fundo da View
        view.backgroundColor = .white
        
        // Configurações da layer
        animLayer.backgroundColor = UIColor.systemBlue.cgColor
        animLayer.frame = CGRect(x: screenWidth/2 - 125, y: screenHeight/2 - 125, width: 250, height: 250)
        animLayer.cornerRadius = 125
        
        // Adicionando a layer à View
        view.layer.addSublayer(animLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.breathAnimation()
        }
    }
    
    private func breathAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 4
        animation.duration = 0.5
        animation.autoreverses = true
        animation.delegate = self
        animLayer.add(animation, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            navigationController?.pushViewController(CreatingNewReflectionViewController(), animated: true)
        }
    }
    

}
