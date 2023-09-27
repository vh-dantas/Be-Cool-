//
//  SettingsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 26/09/23.
//

import UIKit

class SettingsModalViewController: UIViewController {
    
    let options = ["water".localized, "stretch".localized, "walk-around".localized]
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // Define a cor de fundo da view como branco
        navigationItem.title = "settings".localized
        
        let label = UILabel()
        label.text = "hi"
        tableView = UITableView()

        view.addSubview(label)
        view.addSubview(tableView)


        // Set label constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        // Inicializa a table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        // Contraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// Extend o view controller pra entrar em conformidade com a UITableViewDelegate e UITableViewDataSource
extension SettingsModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = options[indexPath.row]
        
        // adiciona um toggle
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = true // estado do toggle
        toggleSwitch.tag = indexPath.row // use uma propriedade pra identificar o row e o estado do toggle
        toggleSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        cell.accessoryView = toggleSwitch
        
        return cell
    }
    
    @objc func switchToggled(_ sender: UISwitch) {
        print("Switch in row \(sender.tag) is \(sender.isOn ? "ON" : "OFF")")
        
        // TODO: Adicionar lógica relacionada a cada toggle on/off
    }
}
