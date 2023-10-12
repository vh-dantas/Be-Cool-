//
//  NewReflectionTableViewCell.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 03/10/23.
//

import UIKit

class NewReflectionTableViewCell: UITableViewCell {
    // MARK: - Variávies
    // Botão da célula
    let newRefBt = UIButton()
    
    // Label da célula
    let cellNewRefLabel = UILabel()
    
    // Shape retangular
    let cellNewRefShape = UIView()
    
    //Imagem do Penguin
    let reflectingPenguin = UIImageView(image: UIImage(named: "pinguimReflecting"))
    
    // ViewController
    let vc = ReflectionViewController()
    
    // MARK: - Inicializadores
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNewRefCell()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SETUP
    func setupNewRefCell() {
        
        addSubview(cellNewRefShape)
        
        // Configurações do botão
        newRefBt.setTitle("reflection-cta-btn".localized, for: .normal)
        newRefBt.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        newRefBt.backgroundColor = UIColor(named: "AccentColor")
        cellNewRefShape.addSubview(newRefBt)
        
        newRefBt.addTarget(self, action: #selector(goToNewReflection), for: .touchUpInside)
        
        // Configurações da label
        cellNewRefLabel.text = "card".localized
        cellNewRefLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        cellNewRefLabel.numberOfLines = 0
        cellNewRefShape.addSubview(cellNewRefLabel)
        
        // Configurações do fundo da célula
        cellNewRefShape.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.15)
        cellNewRefShape.layer.cornerRadius = 10
        
        //Configurações da imagem do pinguim
        cellNewRefLabel.addSubview(reflectingPenguin)
    }
    
    @objc func goToNewReflection() {
        let nextScreen = BreathAnimationViewController()
        nextScreen.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - Constraints
    func constraints() {
        // Fundo da célula
        cellNewRefShape.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellNewRefShape.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellNewRefShape.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellNewRefShape.widthAnchor.constraint(equalToConstant: vc.view.frame.width - 32),
            cellNewRefShape.heightAnchor.constraint(equalToConstant: vc.view.frame.height / 5.5)
        ])
        
        // Label da célula
        cellNewRefLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellNewRefLabel.leadingAnchor.constraint(equalTo: cellNewRefShape.leadingAnchor, constant: 16),
            cellNewRefLabel.topAnchor.constraint(equalTo: cellNewRefShape.topAnchor, constant: 8),
            cellNewRefLabel.widthAnchor.constraint(equalToConstant: vc.view.frame.width / 2.5),
            cellNewRefLabel.heightAnchor.constraint(equalTo: cellNewRefShape.heightAnchor, multiplier: 0.5)
        ])
        
        // Botão da célula
        newRefBt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newRefBt.leadingAnchor.constraint(equalTo: cellNewRefShape.leadingAnchor, constant: 16),
            newRefBt.bottomAnchor.constraint(equalTo: cellNewRefShape.bottomAnchor, constant: -16),
            newRefBt.widthAnchor.constraint(equalToConstant: vc.view.frame.width / 3),
            newRefBt.heightAnchor.constraint(equalTo: cellNewRefShape.heightAnchor, multiplier: 0.25)
        ])
        
        // Imagem do penguin
        reflectingPenguin.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reflectingPenguin.topAnchor.constraint(equalTo: cellNewRefShape.topAnchor),
            reflectingPenguin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reflectingPenguin.widthAnchor.constraint(equalToConstant: vc.view.frame.width * 0.44),
            reflectingPenguin.heightAnchor.constraint(equalToConstant: vc.view.frame.height / 5.5)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newRefBt.layer.cornerRadius = newRefBt.frame.size.height / 2
    }
    
}
