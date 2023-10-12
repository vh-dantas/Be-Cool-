//
//  ReflectionSugestionViewController.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 10/10/23.
//
import UIKit

class ReflectionSugestionViewController: UIViewController {
    // Containers - Views
    private let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "SugestionRefColor")
        return view
    }()
    
    private let bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    // Elementos
    private let cloudsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "CloudsRefSug")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let penguinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Pinguim_MetaAtingidaSVG")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "reflection-suggestion-title".localized
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
        label.text = "reflection-suggestion-body".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        // Criando a configuracao do UIButton - filled diz questão aos elementos internos
        var configuration = UIButton.Configuration.filled()
        configuration.title = "reflection-suggestion-button".localized
        // Configurando a imagem e colocando um tamamho para ela
        configuration.image = UIImage(systemName: "text.bubble.fill")?.applyingSymbolConfiguration(.init(pointSize: 15))
        configuration.titlePadding = 5
        configuration.imagePadding = 5
        configuration.baseBackgroundColor = UIColor(named: "CongratsCollor")
        button.configuration = configuration
        button.tintColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    
    private let laterLabel: UILabel = {
        let label = UILabel()
        label.text = "reflection-suggestion-deny".localized
        let preferredFont = UIFont.preferredFont(forTextStyle: .body)
        let boldFontDescriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor ?? UIFontDescriptor(name: "arial", size: 12), size: 0)
        label.font = boldFont
        label.textColor = UIColor(named: "CongratsCollor")
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .underlineStyle: NSUnderlineStyle.single.rawValue // Adiciona sublinhado
        ]
        // Cria um atributo de texto com os estilos definidos
        let attributedText = NSAttributedString(string: label.text ?? "", attributes: boldAttributes)
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    // MARK: ViewDid Load -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "SugestionRefColor")
        // Adicionando elementos na View
        addToView()
        // Adicionando os layout
        setUpTopContentView()
        setBody()
        setUpButton()
    }
    
    // MARK: Função de adicionar na View
    func addToView(){
        view.addSubview(topContentView)
      //  topContentView.addSubview(cloudsImage)
        topContentView.addSubview(penguinImage)
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(continueButton)
        view.addSubview(laterLabel)
        
       
    }
    // MARK: Funções de constraints
    func setUpTopContentView(){
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: view.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topContentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // Imagens
//            cloudsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//            cloudsImage.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor),
//            cloudsImage.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor),
//            cloudsImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
//            cloudsImage.heightAnchor.constraint(equalTo: topContentView.heightAnchor, multiplier: 0.8),
            penguinImage.centerYAnchor.constraint(equalTo: topContentView.centerYAnchor, constant: 10),
            penguinImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            penguinImage.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor),
            penguinImage.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor),
            penguinImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.84),
            penguinImage.heightAnchor.constraint(equalTo: topContentView.heightAnchor, multiplier: 0.84),
            
//            penguinImage.centerXAnchor.constraint(equalTo: topContentView.centerXAnchor),
//            penguinImage.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: 80),
//            penguinImage.widthAnchor.constraint(equalTo: topContentView.widthAnchor, multiplier: 0.7),
//            penguinImage.heightAnchor.constraint(equalTo: topContentView.heightAnchor, multiplier: 0.7)
        ])
    }

    func setBody(){
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: penguinImage.bottomAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            // Body
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setUpButton() {
        continueButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        laterLabel.isUserInteractionEnabled = true
        laterLabel.addGestureRecognizer(tap)
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 60),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 250),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            // Botao mais tarde
            laterLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 9),
            laterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    @objc private func tapButton(){
        print("PPPPPPOOOOOOUURRRRAAA")
        let reflectionView = BreathAnimationViewController()
        reflectionView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(reflectionView, animated: true)
    }
    
    @objc private func tapFunction(){
        print("Num é que tocou")
        navigationController?.popToRootViewController(animated: true)
    }
    
}
