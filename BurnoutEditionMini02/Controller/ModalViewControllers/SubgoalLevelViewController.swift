//
//  SubgoalLevelViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 29/09/23.
//

import UIKit

class NewSubgoalLevelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Coloca a cor de fundo da modal (ele seta como transparente por padrão)
        view.backgroundColor = .white
        
        
        // MARK: -- SLIDER
        let slider = CustomSlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        view.addSubview(slider)
        
        // Constraints do slider
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // MARK: -- Função para o valor do slider
    @objc func sliderValueChanged(_ sender: CustomSlider) {
        let step: Float = 50 // Snap
        let roundedValue = round(sender.value / step) * step // Param no ponto de snap mais próximo
        sender.value = roundedValue // Arredonda os valores do slider
        sender.customizeThumb()
    }
}



// MARK: -- SLIDER CUSTOMIZADO
class CustomSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeThumb()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeThumb()
    }
    
    // Customiza a bolinha do slider:
    func customizeThumb() {
        let thumbLayer = CALayer()
        thumbLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 30) // ajuste do tamanho da thumb
        thumbLayer.cornerRadius = thumbLayer.bounds.height / 2 // cria o formato de cápsula
        thumbLayer.backgroundColor = UIColor.lightGray.cgColor // cor da cápsula
        
        // Define o visual do slider de acordo com o valor:
        let label = UILabel(frame: thumbLayer.bounds)
        if self.value < 50 {
            label.text = "easy".localized
            self.minimumTrackTintColor = UIColor.lightGray
        } else if self.value == 50 {
            label.text = "medium".localized
            self.minimumTrackTintColor = UIColor.gray
        } else {
            label.text = "hard".localized
            self.minimumTrackTintColor = UIColor.darkGray
        }
        
        label.textAlignment = .center
        label.textColor = .black // cor da label no slider
        
        // Adiciona a label em uma "imagem"
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            label.layer.render(in: currentContext)
            let labelImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Marca a thumb/cápsula como a imagem em que a label vai ser adicionada
            thumbLayer.contents = labelImage?.cgImage
        }
        
        let thumbImage = UIGraphicsImageRenderer(bounds: thumbLayer.bounds).image { _ in
            thumbLayer.render(in: UIGraphicsGetCurrentContext()!)
        }
        self.setThumbImage(thumbImage, for: .normal)
    }
    
    // Customiza o trilho do slider
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 30
        return rect
    }
}
