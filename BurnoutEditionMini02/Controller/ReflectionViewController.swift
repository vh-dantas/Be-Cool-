//
//  ReflectionViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class ReflectionViewController: UIViewController {
    
    // Instância do botão de criar nova reflexão
    let newRefBt = UIButton()
    
    var reflections: [ReflectionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cor de fundo da View
        view.backgroundColor = .white
        
        setupRefBt()
        
    }
    
    // Configurações do botão de nova reflexão: título, cor, posicionamento, etc.
    func setupRefBt() {
        newRefBt.setTitle("New Reflection", for: .normal)
        newRefBt.setTitleColor(.systemBlue, for: .normal)
        newRefBt.backgroundColor = .lightGray
        newRefBt.layer.cornerRadius = 15
        
        // MARK: TO-DO - Usar Auto-Layout ao invés do frame
        newRefBt.frame = CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 23, width: 200, height: 46)
        
        // Navegação do botão
        newRefBt.addTarget(self, action: #selector(goToNewReflection), for: .touchUpInside)
        
        view.addSubview(newRefBt)
    }

    @objc func goToNewReflection() {
        let nextScreen = BreathAnimationViewController()
        nextScreen.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}
