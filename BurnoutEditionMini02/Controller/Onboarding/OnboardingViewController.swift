//
//  OnboardingViewController.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 10/10/23.
//

import UIKit

protocol OnboardingDelegate: AnyObject {
    func didTapButton() -> UIViewController
}

class OnboardingViewController: UICollectionViewController {

    weak var delegate: SceneDelegate?
    
    let realPages: [UICollectionViewCell] = [PageCell1(), PageCell2(), PageCell3()]
    // Botoes da BottomControl
    private let skipLabel: UILabel = {
        let label = UILabel()
        label.text = "Onboarding-skip".localized
        let preferredFont = UIFont.preferredFont(forTextStyle: .callout)
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

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Onboarding-start".localized, for: .normal)
        button.backgroundColor = UIColor(named: "CongratsCollor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 21
        button.layer.masksToBounds = true
        return button
    }()
    private let nextBigButton: UIButton = {
        let button = UIButton()
        button.setTitle("Onboarding-start".localized, for: .normal)
        button.backgroundColor = UIColor(named: "CongratsCollor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 26
        button.layer.masksToBounds = true
        return button
    }()
 
     lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor(named: "CongratsCollor")
        pageControl.numberOfPages = realPages.count
        pageControl.pageIndicatorTintColor = UIColor(named: "LightOrange")
        pageControl.isUserInteractionEnabled = false
        pageControl.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
  
      //  collectionView.backgroundColor = .green
        collectionView.register(PageCell1.self, forCellWithReuseIdentifier: "cellId1")
        collectionView.register(PageCell2.self, forCellWithReuseIdentifier: "cellId2")
        collectionView.register(PageCell3.self, forCellWithReuseIdentifier: "cellId3")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        setUpBottomControls()
        
    }
    
    private func setUpBottomControls(){
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        skipLabel.isUserInteractionEnabled = true
        skipLabel.addGestureRecognizer(tap)

        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        nextBigButton.addTarget(self, action: #selector( tapFunction), for: .touchUpInside)
   
        // Constraints da StackView
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            // Skip Button
            skipLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            skipLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.widthAnchor.constraint(equalToConstant: 100)
            
            // Proporcionalmente
//            nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
//            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28)

        ])
        
        
    }
    
    func setUpConstraints(){
        nextBigButton.removeFromSuperview()
        view.addSubview(skipLabel)
        view.addSubview(nextButton)
        
        // Constraints da StackView
        NSLayoutConstraint.activate([
 
            skipLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            skipLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setUpLastConstraints(){
        skipLabel.removeFromSuperview()
        nextButton.removeFromSuperview()
        view.addSubview(nextBigButton)
        NSLayoutConstraint.activate([
            nextBigButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextBigButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextBigButton.heightAnchor.constraint(equalToConstant: 50),
            nextBigButton.widthAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    // Garantir que nao vai quebrar ao virar a tela
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        if pageControl.currentPage == 2 {
            setUpLastConstraints()
        } else {
            setUpConstraints()
        }
    }
    
    //Tira o espacamento que fica entre cada Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realPages.count
    }
    
    // Tranformo o item em uma PageCell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
          case 0:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId1", for: indexPath) as! PageCell1
              // Configurar a célula com os dados específicos para a página 1
              return cell
          case 1:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath) as! PageCell2
              // Configurar a célula com os dados específicos para a página 2
              return cell
          case 2:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId3", for: indexPath) as! PageCell3
              // Configurar a célula com os dados específicos para a página 3
              return cell
          default:
              fatalError("Índice de célula não reconhecido")
          }
       
  

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            self.collectionViewLayout.invalidateLayout()
            // Casp seja a  priemira pagina ele apenas a coloca no lugar novamente
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            }
            // Se nao for a primeira pagina ele executa um Transition e passa a o item desejado
            else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
}


extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    // Isso faz com que cada item da CollectionView preencha a tela inteira
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}


extension OnboardingViewController {
    // Função de clilcar no botão de proximo - passa para o proximo item
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, realPages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if pageControl.currentPage == 2 {
            setUpLastConstraints()
           
        } else {
            setUpConstraints()
        }
    }
    
    // Função de clilcar no botão de prev - volta para a pagina anterior
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc private func tapFunction(){
        print("Num é que tocou")
        // 1. Altere o valor no UserDefaults para indicar que o onboarding foi concluído
        UserDefaults.standard.set(true, forKey: "Onboarding")
        // 2. Salve as alterações no UserDefaults (opcional em versões mais recentes do iOS)
        UserDefaults.standard.synchronize()
//        
        if let goalsViewController = delegate?.didTapButton() {
          //  self.navigationItem.hidesBackButton = true
            goalsViewController.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(goalsViewController, animated: true)
        }

    }

}



