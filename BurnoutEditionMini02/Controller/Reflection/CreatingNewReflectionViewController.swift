//
//  CreatingNewReflectionViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 25/09/23.
//

import UIKit
import PhotosUI

class CreatingNewReflectionViewController: UIViewController, UITextFieldDelegate, ReflectionCanvasDelegate {
    
    
    
    // MARK: - Variáveis
    // TextField
    var textField: UITextField = UITextField()
    
    // Labels
    let label1 = UILabel()
    let label2 = UILabel()
    
    // Mensagem gerada pelo app para promover a reflexão
    var randomRefQst: String = ""
    
    // Botão para PencilKit
    var drawButton = UIButton()
    let line = UIView()
    let line2 = UIView()
    
    // Botão para acessar a galeria e câmera
    var pictureButton = UIButton()
    var libraryButton = UIButton()
    var imageView = UIImageView()
    
    // Botão para próxima tela
    let nextScreenBt = UIButton()
    
    // BarButtonItens
    var backButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
    
    // Desenho
    var drawing: UIImageView?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        // BarButtonItem
        cancelButton = UIBarButtonItem(title: "", image: UIImage(systemName: "xmark"), target: self, action: #selector(cancelButtonFunc))
        
        // Esconde o botão "back"
        self.navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = cancelButton
        
        // Funções setup
        setupLabels()
        setupTextFields()
        setupDrawButton()
        setupPicBt()
        setupLibraryBt()
        setupImageView()
        setupNextScreenBt()
        
        // Constraints
        constraints()
        
    }
    
    // MARK: - Delegate do desenho
    func didFinishDrawing(_ drawing: UIImageView) {
        self.drawing = drawing
    }
    
    // MARK: - Selector dos BarButtonItem
    
    @objc func cancelButtonFunc() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - NextScreen Button
    private func setupNextScreenBt() {
        // Configurações do botão
        nextScreenBt.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextScreenBt.tintColor = UIColor.white
        nextScreenBt.configuration?.buttonSize = .large
        
        nextScreenBt.backgroundColor = .systemBlue
        nextScreenBt.layer.cornerRadius = 27.5
        
        view.addSubview(nextScreenBt)
        
        nextScreenBt.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
    }
    
    @objc func goToNextScreen() {
        let nextScreen = CreatingNewReflection2ViewController()
        
        nextScreen.randomRefAns = self.textField.text
        nextScreen.randomRefQst = self.randomRefQst
        nextScreen.imageView = self.imageView
        nextScreen.drawing = self.drawing
        
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - Botão para escolher foto da galeria
    private func setupLibraryBt() {
        // Configurações do botão
        libraryButton.setImage(UIImage(systemName: "photo"), for: .normal)
        libraryButton.backgroundColor = .systemGray5
        libraryButton.layer.cornerRadius = 20
        libraryButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        view.addSubview(libraryButton)
        libraryButton.addTarget(self, action: #selector(openLibrary), for: .touchUpInside)
        
        // Linha do meio do botão
        line2.backgroundColor = .systemGray2
        view.addSubview(line2)
        
    }
    
    @objc func openLibrary() {
        
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
        
    }
    
    // MARK: - Botão para desenhar
    private func setupDrawButton() {
        // Configurações do botão de desenho
        drawButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        drawButton.backgroundColor = .systemGray5
        drawButton.layer.cornerRadius = 20
        drawButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        view.addSubview(drawButton)
        drawButton.addTarget(self, action: #selector(goToCanvas), for: .touchUpInside)
    }
    
    @objc func goToCanvas() {
        let canvasVC = ReflectionCanvasViewController()
        canvasVC.delegate = self
        navigationController?.pushViewController(canvasVC, animated: true)
    }
    
    // MARK: - Gerar mensagem random
    private func generateMessage() -> String {
        // Reflexões propostas pelo app
        let message: [String] = ["What have you learned in the past two weeks?",
                                 "How good are you at the thing you were doing?",
                                 "How do you feel after accomplishing your goal?"]
        
        randomRefQst = message[Int.random(in: 0...message.count - 1)]
        
        return randomRefQst
    }
    
    
    
    // MARK: - Labels
    private func setupLabels() {
        
        // Demais labels fixas e configurações
        label1.text = "Reflect about the following question:"
        label1.numberOfLines = 2
        label1.font.withSize(6)
        label1.textColor = .gray
        
        label2.text = generateMessage()
        label2.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label2.numberOfLines = 3
        
        // Adicionando à view
        view.addSubview(label1)
        view.addSubview(label2)
    }
    
    
    // MARK: - TextField
    private func setupTextFields() {
        
        // Configurações básicas do Text Field
        textField.placeholder = "Reflect..."
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.autocapitalizationType = .sentences
        textField.contentVerticalAlignment = .top
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
    }
    
    // MARK: - ImageView
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
    }
    
    // MARK: - Constraints
    private func constraints() {
        // Label 1
        label1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Label 2
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 5),
            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // TextField
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 15),
            textField.widthAnchor.constraint(equalToConstant: screenWidth-40),
            textField.heightAnchor.constraint(equalToConstant: screenHeight/2.5)
        ])
        
        // Botão para desenhar
        drawButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drawButton.heightAnchor.constraint(equalToConstant: 40),
            drawButton.widthAnchor.constraint(equalToConstant: 40),
            drawButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            drawButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16)
        ])
        
        // Linha que separa os dois botões
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.widthAnchor.constraint(equalToConstant: 1),
            line.heightAnchor.constraint(equalToConstant: 40),
            line.centerXAnchor.constraint(equalTo: drawButton.trailingAnchor),
            line.centerYAnchor.constraint(equalTo: drawButton.centerYAnchor)
        ])
        
        // Botão para tirar foto
        pictureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureButton.widthAnchor.constraint(equalToConstant: 40),
            pictureButton.heightAnchor.constraint(equalToConstant: 40),
            pictureButton.centerYAnchor.constraint(equalTo: drawButton.centerYAnchor),
            pictureButton.leadingAnchor.constraint(equalTo: drawButton.trailingAnchor, constant: 1)
        ])
        
        // Linha
        line2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line2.widthAnchor.constraint(equalToConstant: 1),
            line2.heightAnchor.constraint(equalToConstant: 40),
            line2.centerXAnchor.constraint(equalTo: pictureButton.trailingAnchor),
            line2.centerYAnchor.constraint(equalTo: drawButton.centerYAnchor)
        ])
        
        // Botão para acessar a galeria
        libraryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            libraryButton.widthAnchor.constraint(equalToConstant: 40),
            libraryButton.heightAnchor.constraint(equalToConstant: 40),
            libraryButton.centerYAnchor.constraint(equalTo: drawButton.centerYAnchor),
            libraryButton.leadingAnchor.constraint(equalTo: pictureButton.trailingAnchor, constant: 1)
        ])
        
        // ImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: drawButton.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: nextScreenBt.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        // NextScreen Button
        nextScreenBt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextScreenBt.widthAnchor.constraint(equalToConstant: 55),
            nextScreenBt.heightAnchor.constraint(equalToConstant: 55),
            nextScreenBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            nextScreenBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
    }
    
    // MARK: - Picture Button
    private func setupPicBt() {
        
        pictureButton.setImage(UIImage(systemName: "camera"), for: .normal)
        pictureButton.backgroundColor = .systemGray5
        
        view.addSubview(pictureButton)
        
        pictureButton.addTarget(self, action: #selector(takePicture), for: .touchUpInside)
        
        // Linha do meio do botão
        line.backgroundColor = .systemGray2
        view.addSubview(line)
        
        // Imagem
        view.addSubview(imageView)
    }
    
    @objc func takePicture() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
}

// MARK: - Extensão para conformar com os protocolos para tirar a foto
extension CreatingNewReflectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        imageView.image = image
    }
    
}

// MARK: - Extensão para conformar com os protocolos para acessar a galeria
extension CreatingNewReflectionViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        guard let selectedImageResult = results.first else { return }
        
        selectedImageResult.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
            if let image = object as? UIImage {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
