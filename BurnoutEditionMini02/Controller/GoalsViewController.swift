//
//  GoalsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class GoalsViewController: UIViewController {
    
    public weak var delegate: PopUpModalDelegate?
    
    private lazy var canvas: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 10
    view.clipsToBounds = true
    return view
    }()
    
   public override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubview(canvas)
        NSLayoutConstraint.activate([
        self.canvas.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.canvas.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        self.canvas.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.8),
        self.canvas.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.5),
        ])

       self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
}

public protocol PopUpModalDelegate: AnyObject {
// add any functionalities that you want
}

@IBAction func didTapPresent(_ sender: UIButton) {
let view =  GoalsViewController()
view.delegate = self
view.modalPresentationStyle = .overFullScreen
view.modalTransitionStyle = .coverVertical
self.present(view, animated: true)
}
