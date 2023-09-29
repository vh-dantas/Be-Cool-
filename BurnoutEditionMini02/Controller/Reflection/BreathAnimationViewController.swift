//
//  BreathAnimationViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import UIKit

class BreathAnimationViewController: UIViewController, CAAnimationDelegate {
    
    // Criando as layers da animação
    let animLayer = CALayer()
    
    // Texto central (após iniciar animação)
    var labelText = UILabel()
    
    // Texto central (antes de iniciar animação)
    var staticText = UILabel()
    
    // Botão para iniciar a animação
    let startButton = UIButton()
    
    // Grupo que contém as animacões
    var animationGroup: CAAnimationGroup?
    
    // DisplayLink (Labels que alteram conforme a animação passa) e propriedade que rastreia o progresso da animação
    var displayLink: CADisplayLink?
    var animationProgress: CGFloat = 0.0

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cor de fundo da View
        view.backgroundColor = .white
        
        setupLayer()
        setupButton()
        setupLabels()
    }
    
    // MARK: - Botão para iniciar a animação
    private func setupButton() {
        
        startButton.backgroundColor = .clear
        view.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalToConstant: screenWidth),
            startButton.heightAnchor.constraint(equalToConstant: screenHeight)
        ])
        
        startButton.addTarget(self, action: #selector(animation), for: .touchUpInside)
    }
    
    // MARK: - Label que acompanha a animação e label fixa
    private func setupLabels() {
        // Configuração da label que muda
        labelText.font = UIFont.systemFont(ofSize: 40, weight: .black)
        labelText.textColor = UIColor.white
        
        view.addSubview(labelText)
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configuração da label fixa (antes de iniciar a animacão)
        staticText.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        staticText.textColor = UIColor.white
        staticText.text = "Tap to begin"
        
        view.addSubview(staticText)
        
        staticText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            staticText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            staticText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configurações do Display Link
        displayLink = CADisplayLink(target: self, selector: #selector(updateLabel))
        displayLink?.add(to: .current, forMode: .common)
        displayLink?.isPaused = true
        
    }
    
    @objc func updateLabel() {
        
        animationProgress += 1.0 / (animationGroup!.duration)
        
        if animationProgress <= 20 {
            labelText.text = "Inhale"
        } else if animationProgress <= 40 {
            labelText.text = "Hold"
        } else {
            labelText.text = "Exhale"
        }
    }
    
    // MARK: - Configuração e adicão da layer na view
    private func setupLayer() {
        // Configurações da layer
        animLayer.backgroundColor = UIColor.systemBlue.cgColor
        animLayer.frame = CGRect(x: screenWidth/2 - 125, y: screenHeight/2 - 125, width: 250, height: 250)
        animLayer.cornerRadius = 125
        
        // Adicionando a layer à View
        view.layer.addSublayer(animLayer)
    }
    
    // MARK: - Animação
    @objc private func animation() {
        
        // Esconde o navItem "back" e desabilita o botão que começa a animação
        self.navigationItem.hidesBackButton = true
        startButton.isEnabled = false
        
        displayLink?.isPaused = false
        staticText.isHidden = true
        
        // Primeira animação
        let inhaleAnimation       = CABasicAnimation(keyPath: "transform.scale")
        inhaleAnimation.fromValue = 1
        inhaleAnimation.toValue   = 4
        inhaleAnimation.duration  = 4
        inhaleAnimation.delegate  = self
        
        // Segunda animação
        let holdBreathAnimation       = CABasicAnimation(keyPath: "transform.scale")
        holdBreathAnimation.fromValue = 4
        holdBreathAnimation.toValue   = 4
        holdBreathAnimation.duration  = 3
        holdBreathAnimation.beginTime = inhaleAnimation.duration
        holdBreathAnimation.delegate  = self
        
        // Terceira animação
        let exhaleAnimation       = CABasicAnimation(keyPath: "transform.scale")
        exhaleAnimation.fromValue = 4
        exhaleAnimation.toValue   = 1
        exhaleAnimation.duration  = 4
        exhaleAnimation.beginTime = inhaleAnimation.duration + holdBreathAnimation.duration
        exhaleAnimation.delegate  = self
        
        // Animação do fading
        let fadingAnimation       = CABasicAnimation(keyPath: "opacity")
        fadingAnimation.fromValue = 0.2
        fadingAnimation.toValue   = 1
        fadingAnimation.duration  = 1
        fadingAnimation.delegate  = self
        
        // Grupo de animação
        animationGroup                       = CAAnimationGroup()
        animationGroup?.animations            = [inhaleAnimation, fadingAnimation, holdBreathAnimation, exhaleAnimation]
        animationGroup?.duration              = inhaleAnimation.duration + holdBreathAnimation.duration + exhaleAnimation.duration
        animationGroup?.isRemovedOnCompletion = false
        animationGroup?.fillMode              = .forwards
        animationGroup?.delegate              = self
        
        animLayer.add(animationGroup!, forKey: "sequenceAnimation")
    }
    
    // MARK: - Função que navega para próxima view assim que a animação acaba
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            navigationController?.pushViewController(CreatingNewReflectionViewController(), animated: true)
        }
    }
}