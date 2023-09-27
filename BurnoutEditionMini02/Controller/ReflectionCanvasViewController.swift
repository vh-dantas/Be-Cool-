//
//  ReflectionCanvasViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 27/09/23.
//

import UIKit
import PencilKit

class ReflectionCanvasViewController: UIViewController, PKCanvasViewDelegate {

    let canvasView = PKCanvasView()
    var finalDrawing: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Draw your feelings"
        
        setupCanvas()
        setupSaveDrawingButton()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let toolPicker = PKToolPicker()
//        toolPicker.setVisible(true, forFirstResponder: canvasView)
//        toolPicker.addObserver(canvasView)
//        canvasView.becomeFirstResponder()
//    }
    
    private func setupCanvas() {
        
        canvasView.frame = view.bounds
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = self
        
        let drawing = PKDrawing()
        canvasView.drawing = drawing
        
        view.addSubview(canvasView)
        
    }
    
    private func setupSaveDrawingButton() {
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveDrawing))
        navigationItem.rightBarButtonItem = saveButton
        
    }
    
    @objc func saveDrawing() {
        
        let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        finalDrawing = image
        
    }

}
