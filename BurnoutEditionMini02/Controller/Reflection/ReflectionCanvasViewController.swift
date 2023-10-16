//
//  ReflectionCanvasViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 27/09/23.
//

import UIKit
import PencilKit

class ReflectionCanvasViewController: UIViewController, PKCanvasViewDelegate {

    // MARK: - Variáveis
    let canvasView = PKCanvasView()
    var finalDrawing = UIImageView()
    let drawing = PKDrawing()
    let toolPicker = PKToolPicker()
    
    var canvasWidth: CGFloat = 0
    var canvasHeight: CGFloat = 0
    
    var delegate: ReflectionCanvasDelegate?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Botão de voltar
        let backButton = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(backButtonFunc))
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.title = "draw-feels".localized
        setupCanvas()
        setupToolpicker()
        setupSaveDrawingButton()
    }
    
    // MARK: - Selector dos BarButtonItem
    @objc func backButtonFunc() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
    }
    
    // MARK: - SEILA
    override var prefersHomeIndicatorAutoHidden: Bool { return true }
    
    // MARK: - Canvas
    private func setupCanvas() {
        
        canvasWidth = view.bounds.width
        canvasHeight = view.bounds.height
        
        //canvasView.center = CGPoint(x: canvasWidth / 2, y: canvasHeight / 2)
        canvasView.frame = CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight)
        canvasView.drawingPolicy = .anyInput
        canvasView.alwaysBounceVertical = true
        canvasView.delegate = self
        canvasView.drawing = drawing
        
        view.addSubview(canvasView)
        
    }
    
    // MARK: - ToolPicker
    private func setupToolpicker() {
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        
        canvasView.becomeFirstResponder()
        
    }
    
    // MARK: - SaveBt
    private func setupSaveDrawingButton() {
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveDrawing))
        navigationItem.rightBarButtonItem = saveButton
        
    }
    
    @objc private func saveDrawing() {
        
        let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        finalDrawing.image = image
        delegate?.didFinishDrawing(finalDrawing)
        navigationController?.popViewController(animated: true)
        
    }

}

protocol ReflectionCanvasDelegate {
    func didFinishDrawing(_ drawing: UIImageView)
}
