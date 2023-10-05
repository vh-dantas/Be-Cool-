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
    var finalDrawing: UIImage?
    let drawing = PKDrawing()
    let toolPicker = PKToolPicker()
    
    var canvasWidth: CGFloat = 0
    var canvasHeight: CGFloat = 0
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Botão de voltar
        let backButton = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.left"), target: self, action: #selector(backButtonFunc))
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = .white
        self.title = "Draw your feelings"
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
        
       // canvasView.contentSize = CGSize(width: canvasWidth, height: canvasHeight)
        
//        updateContentSizeForDrawing()
        
//        let canvasScale = canvasView.bounds.width / canvasWidth
//        canvasView.minimumZoomScale = canvasScale
//        canvasView.maximumZoomScale = canvasScale
//        canvasView.zoomScale = canvasScale
        
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
    }
    
    // MARK: - Update Content View
//    private func updateContentSizeForDrawing() {
//
//        let drawing = canvasView.drawing
//        let contentHeight: CGFloat
//
//        if !drawing.bounds.isNull {
//            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + self.canvasHeight) * canvasView.zoomScale)
//        } else {
//            contentHeight = canvasView.bounds.height
//        }
//
//        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: contentHeight)
//
//
//    }
    
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
    
    // MARK: - Função que roda ao trocar a orientação do dispositivo
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//
//        if UIDevice.current.orientation.isPortrait {
//            canvasHeight = view.bounds.height
//            canvasWidth = view.bounds.width
//            canvasView.frame.size = CGSize(width: canvasWidth, height: canvasHeight)
//            canvasView.center = CGPoint(x: canvasWidth / 2, y: canvasHeight / 2)
//            //canvasView.zoomScale = 5.0
//        } else {
//            canvasHeight = view.bounds.width
//            canvasWidth = view.bounds.height
//            canvasView.frame.size = CGSize(width: canvasWidth, height: canvasHeight)
//            canvasView.center = CGPoint(x: canvasWidth / 2, y: canvasHeight / 2)
//        }
//
//    }
    
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
        finalDrawing = image
        
    }

}
