//
//  OnboardingPageCell.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 10/10/23.
//
import UIKit
// Struct que guarda as informacoes da pagina - Model
struct Page {
    let imageName: String
    let headerText: String
    let bodyText: String
}

class PageCell1: UICollectionViewCell {
    // Conteúdo da tela
    private let burnImage: UIImageView = {
        let burnImage = UIImageView()
        burnImage.image = UIImage(named: "Ilustração Onboarding 1")
        burnImage.translatesAutoresizingMaskIntoConstraints = false
        burnImage.contentMode = .scaleAspectFit
        return burnImage
    }()
    
    private let descriptionTextView: UILabel = {
        let label = UILabel()
         label.text = "Onboarding-title1".localized
         label.translatesAutoresizingMaskIntoConstraints = false
         label.adjustsFontForContentSizeCategory = true
         // Obtém a fonte preferida para o estilo de texto .callout
         let preferredFont = UIFont.preferredFont(forTextStyle: .title1)
         // Cria um descritor de fonte com estilo em negrito
         let boldFontDescriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
         // Verifica se o descritor de fonte em negrito é nulo
         let boldFont = UIFont(descriptor: boldFontDescriptor ?? UIFontDescriptor(name: "arial", size: 12), size: 0)
         // Define a nova fonte em negrito para a sua label
         label.font = boldFont
         label.numberOfLines = 0
         label.lineBreakMode = .byWordWrapping
         label.textAlignment = .center
         return label
    }()
    
    private let bodyLabel: UILabel = {
       let label = UILabel()
        label.text = "Onboarding-body2".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let topImageContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionTextView)
        addSubview(topImageContainerView)
        addSubview(bodyLabel)
        topImageContainerView.addSubview(burnImage)
        // Layout View Constraints
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leftAnchor.constraint(equalTo: leftAnchor),
            topImageContainerView.rightAnchor.constraint(equalTo: rightAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        NSLayoutConstraint.activate([
            burnImage.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: -20),
            burnImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            //  burnImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            burnImage.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.8),
            burnImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -36),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 36),
            //descriptionTextView.bottomAnchor.constraint(equalTo: ),
            
            bodyLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            bodyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
        ])
    }
}

class PageCell2: UICollectionViewCell {
    // Conteúdo da tela
    private let burnImage: UIImageView = {
        let burnImage = UIImageView()
        burnImage.image = UIImage(named: "Ilustração Onboarding 2")
        burnImage.translatesAutoresizingMaskIntoConstraints = false
        burnImage.contentMode = .scaleAspectFit
        return burnImage
    }()
    
    private let descriptionTextView: UILabel = {
        let label = UILabel()
         label.text = "Onboarding-title2".localized
         label.translatesAutoresizingMaskIntoConstraints = false
         label.adjustsFontForContentSizeCategory = true
         // Obtém a fonte preferida para o estilo de texto .callout
         let preferredFont = UIFont.preferredFont(forTextStyle: .title1)
         // Cria um descritor de fonte com estilo em negrito
         let boldFontDescriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
         // Verifica se o descritor de fonte em negrito é nulo
         let boldFont = UIFont(descriptor: boldFontDescriptor ?? UIFontDescriptor(name: "arial", size: 12), size: 0)
         // Define a nova fonte em negrito para a sua label
         label.font = boldFont
         label.numberOfLines = 0
         label.lineBreakMode = .byWordWrapping
         label.textAlignment = .center
         return label
    }()
    
    private let bodyLabel: UILabel = {
       let label = UILabel()
        label.text = "Onboarding-body2".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let topImageContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionTextView)
        addSubview(topImageContainerView)
        addSubview(bodyLabel)
        topImageContainerView.addSubview(burnImage)
        // Layout View Constraints
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leftAnchor.constraint(equalTo: leftAnchor),
            topImageContainerView.rightAnchor.constraint(equalTo: rightAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        NSLayoutConstraint.activate([
            burnImage.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: -20),
            burnImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            //  burnImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            burnImage.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.8),
            burnImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8),
            
            descriptionTextView.topAnchor.constraint(equalTo: burnImage.bottomAnchor, constant: 33),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            //descriptionTextView.bottomAnchor.constraint(equalTo: ),
            
            bodyLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            bodyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),

        ])
    }
}

class PageCell3: UICollectionViewCell {
    // Conteúdo da tela
    private let burnImage: UIImageView = {
        let burnImage = UIImageView()
        burnImage.image = UIImage(named: "Ilustração Onboarding 3")
        burnImage.translatesAutoresizingMaskIntoConstraints = false
        burnImage.contentMode = .scaleAspectFit
        return burnImage
    }()
    
    private let descriptionTextView: UILabel = {
        let label = UILabel()
         label.text = "Onboarding-title3".localized
         label.translatesAutoresizingMaskIntoConstraints = false
         label.adjustsFontForContentSizeCategory = true
         // Obtém a fonte preferida para o estilo de texto .callout
         let preferredFont = UIFont.preferredFont(forTextStyle: .title1)
         // Cria um descritor de fonte com estilo em negrito
         let boldFontDescriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
         // Verifica se o descritor de fonte em negrito é nulo
         let boldFont = UIFont(descriptor: boldFontDescriptor ?? UIFontDescriptor(name: "arial", size: 12), size: 0)
         // Define a nova fonte em negrito para a sua label
         label.font = boldFont
         label.numberOfLines = 0
         label.lineBreakMode = .byWordWrapping
         label.textAlignment = .center
         return label
    }()
    
    private let bodyLabel: UILabel = {
       let label = UILabel()
        label.text = "Onboarding-body3".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
       
        return label
    }()
    
    private let topImageContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionTextView)
        addSubview(topImageContainerView)
        addSubview(bodyLabel)
        topImageContainerView.addSubview(burnImage)
        // Layout View Constraints
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leftAnchor.constraint(equalTo: leftAnchor),
            topImageContainerView.rightAnchor.constraint(equalTo: rightAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        NSLayoutConstraint.activate([
            burnImage.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20),
            burnImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            //  burnImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            burnImage.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.8),
            burnImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8),
            
            descriptionTextView.topAnchor.constraint(equalTo: burnImage.bottomAnchor, constant: 32),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            //descriptionTextView.bottomAnchor.constraint(equalTo: ),
            
            bodyLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            bodyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
        ])
    }
}

class PageCell: UICollectionViewCell {
    
    var pages: Page? {
        didSet {
            guard let unwappedPage = pages else { return }
            // Setando o estilo das Strings
            let preferredFont = UIFont.preferredFont(forTextStyle: .title1)
            let boldFontDescriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
            let boldFont = UIFont(descriptor: boldFontDescriptor ?? UIFontDescriptor(name: "arial", size: 12), size: 0)
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: boldFont
            ]
            let attributedText = NSMutableAttributedString(string: unwappedPage.headerText, attributes: boldAttributes)
            attributedText.append(NSAttributedString(string: unwappedPage.bodyText, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body), NSAttributedString.Key.foregroundColor: UIColor.black]))
            
            burnImage.image = UIImage(named: unwappedPage.imageName)
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Conteúdo da tela
    private let burnImage = UIImageView()
    private let descriptionTextView = UITextView()
    private let topImageContainerView = UIView()
    
    func style(){
        // Penguin Image
        burnImage.image = UIImage(named: "PengionFrio")
        burnImage.translatesAutoresizingMaskIntoConstraints = false
        burnImage.contentMode = .scaleAspectFit
        
        
        let attributedText = NSMutableAttributedString(string: "Bem vindo ao FillOut", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\n\nOlá, me chamo Chillie, e estou aqui para ser seu guia e companheiro nesta jornada em direção ao bem-estar e à prevenção do burnout. 😊", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        //        descriptionTextView.text = "Bem vindo ao FillOut" -- Substrituir pelo atribbute text
        //        descriptionTextView.font = UIFont.boldSystemFont(ofSize: 18)
        descriptionTextView.attributedText = attributedText
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.textAlignment = .center
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        
        //Top View
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {

        addSubview(descriptionTextView)
        addSubview(topImageContainerView)
        topImageContainerView.addSubview(burnImage)
        // Layout View Constraints
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leftAnchor.constraint(equalTo: leftAnchor),
            topImageContainerView.rightAnchor.constraint(equalTo: rightAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            burnImage.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: -20),
            burnImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            //  burnImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            burnImage.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.8),
            burnImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
      
        
        
    }
    
    
}



