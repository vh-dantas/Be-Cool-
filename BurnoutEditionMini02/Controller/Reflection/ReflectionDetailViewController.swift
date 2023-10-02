





import UIKit

class ReflectionDetailViewController: UIViewController {
    
    // Label da data
    let dateLabel = UILabel()
    
    // Label para o body da reflection
    let bodyLabel = UITextView()
    
    // Criando a StackView para por as Tags
    let tagStackView = UIStackView()
    // Criando as tags
    let tagMood = RectangleLabelView(frame: CGRect(x: 0, y: 0, width: 100, height: 30), text: "vaaaaaaai")
    let tagGoal = RectangleLabelView(frame: CGRect(x: 0, y: 0, width: 100, height: 30), text: "Meta muito foda aaaa")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //Setando o titulo
        navigationItem.title = "Refletion 1"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Configurando a Label de tempo
        configDateLabel()
        // Configurando as Tags
        view.addSubview(tagStackView)
        tagStackView.addArrangedSubview(tagGoal)
        tagStackView.addArrangedSubview(tagMood)
        configureTags()
        
        // Configurando a BodyLabel
        view.addSubview(bodyLabel)
        configureBodyLabel()
        
    }
    
 
    
    // Função para configurar a data da reflection
    func configDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        
        // Set label properties
        dateLabel.text = "23 DE setembro DE 2023"
        dateLabel.text = dateLabel.text?.uppercased()
      //  dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.gray
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.numberOfLines = 0
        dateLabel.lineBreakMode = .byWordWrapping
        // Desembrulhando a nav bar para conseguir acessar suas constraitns e adicionar a label
//        if let navigationBar = self.navigationController?.navigationBar {
//            navigationBar.addSubview(dateLabel)
//            // A constraint top é ancorada com o titulo - a leading possui constant para alinhar com o titulo
//            NSLayoutConstraint.activate([
//                dateLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
//                dateLabel.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 17)
//            ])
//
//        }
        // Adicionando a dateLabel na view - seus anchor sao de acordo com a safe area e as constants são para alinhar melhor com o titulo
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 17),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -17)
            
        ])
    }
    
    // Função para configurar as tags - elas estao dentro de uma UIStackView entao configuro aqui tambem
    func configureTags(){

        tagGoal.translatesAutoresizingMaskIntoConstraints = false
        tagMood.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurando a StackView
        //tagStackView.axis = .vertical
        tagStackView.spacing = 16
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let tags = ["METAAAAA FODAAAA", "Tag 2", "Raiva e morte e tristeza", "Cabuloso"]
        
        
       
        NSLayoutConstraint.activate([
            tagStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tagStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 21)
          //  tagStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
    }
    
    // Func=ção para configurar o texto vody da reflection - usado UITextView para fazer o ajuste automatico na tela
    func configureBodyLabel(){
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
   //     bodyLabel.textAlignment =
        bodyLabel.adjustsFontForContentSizeCategory = true
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bodyLabel.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem."
        bodyLabel.isEditable = false
        bodyLabel.isScrollEnabled = false
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: tagStackView.bottomAnchor, constant: 35),
            bodyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            bodyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
            
        ])
        
    }
}




class RectangleLabelView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        //precisa usar isso aqui pra da o autofont
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
     init(frame: CGRect, text: String) {
        super.init(frame: frame)
        backgroundColor = .gray // Cor de fundo do retângulo
        addSubview(label)
         // Colocando o texto na label
         label.text = text
         
         NotificationCenter.default.addObserver(self, selector: #selector(handleContentSizeCategoryChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
         
        //Setando as contates das constraints para dar o espacamento entr o texto e o rectangle
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
         // Chamando a funcao para setar o corner radius
         updateCornerRadius()
         
     }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        // Remover a observação da notificação ao liberar a memória
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // Função para atualizar o corner da tag quando ela for trocada no sistema - vai ser usada na notification
    @objc private func handleContentSizeCategoryChange(){
        updateCornerRadius()
        layoutIfNeeded()
    }
    
    // Rounded Rectangle de acordo com o tamanho da fonte no sistema
     func updateCornerRadius(){
        let fontSize = label.font.pointSize
        var maxCornerRadius: CGFloat = 20 // Valor máximo para cornerRadius
        let minCornerRadius: CGFloat = 5 // Valor mínimo para cornerRadius
        
        // Verificando caso a fonte seja muito grande
        if fontSize >= 33 {
            maxCornerRadius = 33
        }  else if fontSize >= 30 && fontSize < 33 {
            maxCornerRadius = 30
        } else if fontSize >= 25 && fontSize < 30 {
            maxCornerRadius = 22
        }
         
        // varificando caso a fonte seja menos do que o padrao
         if fontSize < 12  && fontSize > 6{
             maxCornerRadius = 16
         } else if fontSize <= 6 {
             maxCornerRadius = 12
         }
 
        // Definir o cornerRadius com base no tamanho da fonte, mas limite-o dentro dos valores máximo e mínimo
        layer.cornerRadius = max(min(fontSize / 2, minCornerRadius), maxCornerRadius)
    }
    
}
