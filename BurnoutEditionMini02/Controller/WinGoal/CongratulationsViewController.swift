
import UIKit

class CongratulationsViewController: UIViewController {
    // Containers - Views
    private let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    // Elementos
    private let bigMedalImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "BigMedal")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "congratulations-title".localized
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
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "congratulations-sub-title".localized
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        let preferredFont = UIFont.preferredFont(forTextStyle: .body)
        let boldFontDescriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor ?? UIFontDescriptor(name: "arial", size: 12), size: 0)
        label.font = boldFont
        label.textAlignment = .center
        return label
    }()
    
    private let bodyLabel: UILabel = {
       let label = UILabel()
        label.text = "congratulations-body".localized
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
        button.setTitle("congratulations-button".localized, for: .normal)
        button.backgroundColor = UIColor(named: "CongratsCollor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "congratulations-button".localized
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    // MARK: ViewDid Load -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        topContentView.addSubview(bigMedalImage)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(continueButton)
        
       
    }
    // MARK: Funções de constraints
    func setUpTopContentView(){
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topContentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // Imagem - BigMedal
            bigMedalImage.centerXAnchor.constraint(equalTo: topContentView.centerXAnchor),
            bigMedalImage.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: -10),
            bigMedalImage.widthAnchor.constraint(equalTo: topContentView.widthAnchor, multiplier: 0.8),
            bigMedalImage.heightAnchor.constraint(equalTo: topContentView.heightAnchor, multiplier: 0.8)
        ])
    }

    func setBody(){
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: bigMedalImage.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // SubTItle
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Body
            bodyLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setUpButton() {
        continueButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 54),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 250),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func tapButton(){
        let nextView = ReflectionSugestionViewController()
        nextView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextView, animated: true)
        print("PPPPPPOOOOOOUURRRRAAA")
    }
    
}
