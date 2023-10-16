import UIKit

class ReflectionDetailViewController: UIViewController {
    
    // Scroll View
    let scrollView = UIScrollView()
    // Label da data
    let dateLabel = UILabel()
    // Labl para o body da reflection
    let bodyLabel = UITextView()
    // Criando a StackView para por as Tags
    let tagStackView = UIStackView()
    var tagCollectionView: UICollectionView! = nil
    // Criando as tags
    let tagMood = RectangleLabelView(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
    //let tagGoal = RectangleLabelView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    // Imagem e desenho
    var imagem = UIImageView()
    var drawing = UIImageView()
    
    // Tags
    var tags: [String] = []
    
    // Reflection passada pela view anterior
    var reflection: ReflectionEntity
    
    // MARK: - Inicializadores
    init(reflection: ReflectionEntity) {
        self.reflection = reflection
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Função ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //Setando o titulo
        navigationItem.title = reflection.refName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configurando a ScrollView
        setUpScrollView()
        
        // Configurando a Label de tempo
        configDateLabel()
        
        // Array que armazena os nomes das tags
        //tags = ["paralelepipedo paralelepipedo", reflection.mood ?? ""]
        tags = [reflection.mood ?? "_"]
        
        // Configurando as Tags com CollectionVirw
        setUpCollectionView()
        // Configurando a BodyLabel
        view.addSubview(bodyLabel)
        configureBodyLabel()
        
        // Imagens e desenhos
        setupImgs()
        
    }
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tagCollectionView.reloadData()
        }
      
    }
    
    // MARK: - Imagens e desenhos
    private func setupImgs() {
        // Convertendo Binary Data para imagem
        if let imageData = reflection.image {
            if let image = UIImage(data: imageData) {
                imagem.image = image
                
                // Configurações da imagem
                imagem.layer.cornerRadius = 20
                imagem.clipsToBounds = true
                imagem.contentMode = .scaleAspectFill
                
                view.addSubview(imagem)
                
                imagem.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imagem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    imagem.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 35),
                    imagem.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                    imagem.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
                ])
            }
        }
        
        // Convertendo Binary Data para imagem
        if let drawingData = reflection.drawing {
            if let draw = UIImage(data: drawingData) {
                drawing.image = draw
                
                // Configurações do desenho
                drawing.layer.cornerRadius = 20
                drawing.clipsToBounds = true
                drawing.contentMode = .scaleAspectFill
                
                view.addSubview(drawing)
                
                drawing.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    drawing.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    drawing.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                    drawing.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
                ])
                // Se houver imagem, o desenho ficará embaixo dele, se não, embaixo da bodyLabel
                if imagem.image != nil {
                    
                    drawing.topAnchor.constraint(equalTo: imagem.bottomAnchor, constant: 20).isActive = true
                    
                } else {
                    
                    drawing.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20).isActive = true
                }
            }
        }
    }
    
    // MARK: - ScrollView
    func setUpScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - CollectionView
    func setUpCollectionView(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 6
        
        
        tagCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.dataSource = self
        tagCollectionView.backgroundColor = UIColor(named: "BackgroundColor")
        tagCollectionView.register(RectangleLabelView.self, forCellWithReuseIdentifier: RectangleLabelView.reuseIdentifier)
        tagCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tagCollectionView)
        
        // Pegar o tamanho da fonte para conseguir calcular o tamanho necessario para as tags
        let multiplierHeight: CGFloat = {
            var multiplier = CGFloat()
            if dateLabel.font.pointSize >= 28 {
                multiplier = 0.2
            } else if dateLabel.font.pointSize <= 12 {
                multiplier = 0.07
            } else if dateLabel.font.pointSize >= 13 && dateLabel.font.pointSize <= 18 {
                multiplier = 0.8
            } else {
                multiplier = 0.15
            }
            return multiplier
        }()
        
        NSLayoutConstraint.activate([
            tagCollectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            tagCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            // tagCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tagCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplierHeight),
            tagCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.99)
        ])
        
        
    }
    
    
    // Função para configurar a data da reflection MARK: - DateLabel
    func configDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        
        // Set label properties
        let date = reflection.date ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        let formatedDate = dateFormatter.string(from: date)
        
        dateLabel.text = formatedDate
        dateLabel.text = dateLabel.text?.uppercased()
      //  dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.gray
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.numberOfLines = 0
        dateLabel.lineBreakMode = .byWordWrapping
        // Adicionando a dateLabel na view - seus anchor sao de acordo com a safe area e as constants são para alinhar melhor com o titulo
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 17),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -17)
            
        ])
    }
    
    // Função para configurar as tags - elas estao dentro de uma UIStackView entao configuro aqui tambem MARK: Tags
    func configureTags(){

        //tagGoal.translatesAutoresizingMaskIntoConstraints = false
        tagMood.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurando a StackView
        //tagStackView.axis = .vertical
        tagStackView.spacing = 16
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tagStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tagStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 21)
          //  tagStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
    }
    
    // Função para configurar o texto vody da reflection - usado UITextView para fazer o ajuste automatico na tela MARK: BodyLabel
    func configureBodyLabel(){
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
   //     bodyLabel.textAlignment =
        bodyLabel.adjustsFontForContentSizeCategory = true
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bodyLabel.text = reflection.randomRefAns
        bodyLabel.isEditable = false
        bodyLabel.isScrollEnabled = false
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: tagCollectionView.bottomAnchor), // constant: 35
            bodyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            bodyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
            
        ])
        
    }
}

// MARK: DataSource
extension ReflectionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RectangleLabelView.reuseIdentifier, for: indexPath) as! RectangleLabelView
        cell.configure(with: tags[indexPath.item])
        return cell
    }
    
    // Implementar o método sizeForItemAt para calcular o tamanho das células com base no conteúdo
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let tag = tags[indexPath.item]
         let labelSize = (tag as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)])
         return CGSize(width: labelSize.width + 40, height: labelSize.height + 20)
     }
    
}

class RectangleLabelView: UICollectionViewCell {
    static let reuseIdentifier = "cell-reuse-identifier"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        //precisa usar isso aqui pra da o autofont
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray // Cor de fundo do retângulo
        addSubview(label)
         // Colocando o texto na label
         
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
    
    func configure(with text: String) {
          label.text = text
      }
    
    // Função para atualizar o corner da tag quando ela for trocada no sistema - vai ser usada na notification
    @objc private func handleContentSizeCategoryChange(){
        updateCornerRadius()
        layoutIfNeeded()
    }
    
    // Rounded Rectangle de acordo com o tamanho da fonte no sistema
     func updateCornerRadius(){
        let fontSize = label.font.pointSize
        var maxCornerRadius: CGFloat = 17 // Valor máximo para cornerRadius
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
