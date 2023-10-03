//
//  ReflectionTableViewCell.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 03/10/23.
//

import UIKit

class ReflectionTableViewCell: UITableViewCell {
    
    // MARK: - Variáveis
    // Botão da célula
    let refShape = UIView()
    
    // Círculo atrás do mood
    let refCircleBg = UIView()
    
    // Mood da célula
    let refMood = UILabel()
    
    // Título da reflection
    let refTitle = UILabel()
    
    // Data da reflection
    let refDate = UILabel()
    
    // Divider
    let refDiv = UIView()
    
    // Reflection (texto, desenho ou imagem)
    let refText = UILabel()
    //var refImage: UIImage?
    
    // ViewController
    let vc = ReflectionViewController()

    // MARK: - Inicializadores
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout da célula
    func setupLayout() {
        
        // Configuração do shape
        addSubview(refShape)
        refShape.layer.cornerRadius = 10
        refShape.backgroundColor = .systemGray4
        
        // Configuração do background do mood
        refCircleBg.backgroundColor = .systemGray6
        refCircleBg.layer.cornerRadius = vc.view.frame.width / 9.6
        refShape.addSubview(refCircleBg)
        
        // Configuracão do mood
        refMood.font = UIFont.systemFont(ofSize: 50)
        refShape.addSubview(refMood)
        
        // Configuração da label TÍTULO DA REFLECTION
        refTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        refShape.addSubview(refTitle)
        
        // Configuração da data
        refDate.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        refShape.addSubview(refDate)
        
        // Configuração do divider
        refDiv.backgroundColor = .systemGray
        refShape.addSubview(refDiv)
        
        // Configuração do texto da reflection
        refText.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        refText.numberOfLines = 3
        refShape.addSubview(refText)
    }
    
    func set(reflection: ReflectionModel) {
        refMood.text = reflection.mood
        refTitle.text = reflection.name
        refDate.text = reflection.date
        refText.text = reflection.randomRefAns
    }
    
    func constraints() {
        // Shape
        refShape.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refShape.widthAnchor.constraint(equalToConstant: vc.view.frame.width - 64),
            refShape.heightAnchor.constraint(equalToConstant: vc.view.frame.height / 8.2),
            refShape.centerXAnchor.constraint(equalTo: centerXAnchor),
            refShape.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Mood background
        refCircleBg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refCircleBg.widthAnchor.constraint(equalToConstant: vc.view.frame.width / 4.8),
            refCircleBg.heightAnchor.constraint(equalToConstant: vc.view.frame.width / 4.8),
            refCircleBg.centerYAnchor.constraint(equalTo: refShape.centerYAnchor),
            refCircleBg.leadingAnchor.constraint(equalTo: refShape.leadingAnchor, constant: 16)
        ])
        
        // Mood
        refMood.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refMood.centerXAnchor.constraint(equalTo: refCircleBg.centerXAnchor),
            refMood.centerYAnchor.constraint(equalTo: refCircleBg.centerYAnchor)
        ])
        
        // Título da Reflection
        refTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refTitle.topAnchor.constraint(equalTo: refShape.topAnchor, constant: 10),
            refTitle.leadingAnchor.constraint(equalTo: refCircleBg.trailingAnchor, constant: 16)
        ])
        
        // Data
        refDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refDate.topAnchor.constraint(equalTo: refTitle.topAnchor),
            refDate.trailingAnchor.constraint(equalTo: refShape.trailingAnchor, constant: -16)
        ])
        
        // Divider
        refDiv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refDiv.leadingAnchor.constraint(equalTo: refTitle.leadingAnchor),
            refDiv.trailingAnchor.constraint(equalTo: refShape.trailingAnchor),
            refDiv.topAnchor.constraint(equalTo: refTitle.bottomAnchor),
            refDiv.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // Texto
        refText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refText.leadingAnchor.constraint(equalTo: refDiv.leadingAnchor),
            refText.trailingAnchor.constraint(equalTo: refDate.trailingAnchor),
            refText.topAnchor.constraint(equalTo: refDiv.bottomAnchor, constant: 5),
            refText.bottomAnchor.constraint(equalTo: refShape.bottomAnchor, constant: -16)
        ])
        
    }
    
}
