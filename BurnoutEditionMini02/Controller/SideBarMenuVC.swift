//
//  SideBarMenuVC.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 09/10/23.
//

import UIKit

class SideBarMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Variáveis
    let tableView = UITableView()
    
    let buttonsImage: [String] = ["list.bullet.circle.fill",
                                  "medal.fill",
                                  "text.bubble.fill",
                                  "gearshape.fill"]
    
    let buttonsLabel: [String] = ["goals".localized,
                                  "achievements".localized,
                                  "reflections".localized,
                                  "settings".localized]
    
    var buttonTapped: String?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.title = "App's name"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // setup
        setupTableView()
        
        // constraints
        constraints()
    }
    
    // MARK: - TableView
    private func setupTableView() {
        // Adicionando à view
        view.addSubview(tableView)
        
        // Delegates da tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Estilo do separador
        tableView.separatorStyle = .none
        
        // Desativando o scroll
        tableView.isScrollEnabled = false
        
        // Registro da célula
        tableView.register(sideBarButtonCell.self, forCellReuseIdentifier: "buttonCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonsImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let i = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! sideBarButtonCell
        let buttonImage = buttonsImage[i]
        let buttonLabel = buttonsLabel[i]
        cell.set(label: buttonLabel, image: buttonImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.05
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buttonTapped = buttonsLabel[indexPath.row]
    }
    
    // MARK: - Constraints
    private func constraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



// MARK: - Célula da TableView
class sideBarButtonCell: UITableViewCell {
    // MARK: - Variáveis
    var image = UIImageView()
    var label = UILabel()
    let shape = UIView()
    
    let vc = SideBarMenuVC()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SETUP
    func set(label: String, image: String) {
        self.label.text = label
        self.image.image = UIImage(systemName: image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            label.textColor = .systemBackground
            image.tintColor = .systemBackground
            shape.backgroundColor = UIColor(named: "AccentColor")
        } else {
            label.textColor = .black
            image.tintColor = UIColor(named: "AccentColor")
            shape.backgroundColor = .none
        }
    }
    
    private func constraints() {
        // Adicionando à view
        addSubview(shape)
        addSubview(image)
        addSubview(label)
        
        // Constraints
        shape.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // SHAPE
            shape.leadingAnchor.constraint(equalTo: leadingAnchor),
            shape.trailingAnchor.constraint(equalTo: trailingAnchor),
            shape.topAnchor.constraint(equalTo: topAnchor),
            shape.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // IMAGE
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            // LABEL
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
        
    }
}


