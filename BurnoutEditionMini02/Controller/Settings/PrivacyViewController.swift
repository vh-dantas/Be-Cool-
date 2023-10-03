//
//  PrivacyViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 01/10/23.
//

import UIKit

class PrivacyViewController: UIViewController {
    
        var scrollView: UIScrollView!
        var contentView: UIView!
        var privacyPolicy: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Background da view
            view.backgroundColor = .white
            
            // Setup do scroll view
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            
            // Cria uma content view pra adicionar como filha da scroll view
            contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            
            // Cria as labels para adicionar na content view
            privacyPolicy = UILabel()
            privacyPolicy.numberOfLines = 0 // Permite que o label não tenha um limite de linhas
            privacyPolicy.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(privacyPolicy)
            
            // String com dynamic type
            let titleFont = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: 17))
            let textFont = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15))
            
            // Configurações do visual dos títulos
            let titleStyling: [NSAttributedString.Key: Any] = [
                .font: titleFont,
                .foregroundColor: UIColor.black
            ]
            // Configurações do viausla dos textos
            let textStyling: [NSAttributedString.Key: Any] = [
                .font: textFont,
                .foregroundColor: UIColor.lightGray
            ]
            
            // Títulos e textos localizados
            let titles = ["PrivacyTitle1".localized, "PrivacyTitle2".localized, "PrivacyTitle3".localized, "PrivacyTitle4".localized]
            let texts = ["PrivacyText1".localized, "PrivacyText2".localized, "PrivacyText3".localized, "PrivacyText4".localized]
            
            // Cria uma string que pode ter estilos diferentes em partes do mesmo texto
            let finalText = NSMutableAttributedString()
            
            // Loop que percorre todos os textos
            for i in 0..<titles.count {
                // Cria uma string pra cada título com o estilo definido em titleStyling
                let title = NSAttributedString(string: titles[i] + "\n", attributes: titleStyling)
                // Cria uma string pra cada texto com o estilo definido em textStyling
                let text = NSAttributedString(string: texts[i] + "\n\n", attributes: textStyling)
                
                // Adiciona essas strings à string final
                finalText.append(title)
                finalText.append(text)
            }
            // string final com diferentes estilos
            privacyPolicy.attributedText = finalText
            
            // Constraints da scroll view
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            // Constraints da content view
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                
                // constraints pra fazer o scroll view funcionar direito
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
            ])
            
            // Constraints pras labels
            NSLayoutConstraint.activate([
                privacyPolicy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                privacyPolicy.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                privacyPolicy.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                
                // constraint pra fazer o scroll do texto funcionar direito
                privacyPolicy.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
            ])
        }
    }
