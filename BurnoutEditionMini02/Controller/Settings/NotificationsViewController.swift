//
//  NotificationsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 02/10/23.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    
    var notificationsAllowed = false

    
    let options = ["water".localized, "stretch".localized, "walk-around".localized]
    
    var tableView: UITableView!
    var includeWeekendsSwitch: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewStyle() // define o visual da view
        setupWeekends() // horário de trabalho do usuário
        setupActivities() 
    }
    
    
    // MARK: -- SETUP VISUAL DA VIEW
    func setupViewStyle() {
        view.backgroundColor = .white
        navigationItem.title = "notifications".localized
    }
    
    
    // MARK: -- SETUP DAS NOTIFICAÇÕE NOS FINAIS DE SEMANA
    func setupWeekends() {

        // Label
        let includeWeekendsLabel = UILabel()
        includeWeekendsLabel.text = "Include weekends:"
        
        // Toggle/Switch - Incluir finais de semana
        includeWeekendsSwitch = UISwitch()
        includeWeekendsSwitch.isOn = false // Default: off
        includeWeekendsSwitch.addTarget(self, action: #selector(weekendToggled(_:)), for: .valueChanged)
        
        // Adiciona os componentes na view
        view.addSubview(includeWeekendsLabel)
        view.addSubview(includeWeekendsSwitch)
        
        // Constraints: Label
        includeWeekendsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            includeWeekendsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            includeWeekendsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            includeWeekendsLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        // Constraints: Toggle/Switch
        includeWeekendsSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            includeWeekendsSwitch.centerYAnchor.constraint(equalTo: includeWeekendsLabel.centerYAnchor),
            includeWeekendsSwitch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
    }


    
    // MARK: -- SETUP DA TABLEVIEW DE ATIVIDADES
    func setupActivities() {
        
        // Label
        let reminderLabel = UILabel()
        reminderLabel.text = "Select what you would like to be reminded:"
        
        // Inicializa a tableview
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Adiciona os componentes na view
        view.addSubview(reminderLabel)
        view.addSubview(tableView)
        
        // Constraints: Label
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reminderLabel.topAnchor.constraint(equalTo: includeWeekendsSwitch.bottomAnchor, constant: 20),
            reminderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            reminderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        // Constraints da table view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func weekendToggled(_ sender: UISwitch) {
            if sender.isOn {
                print("Weekends is on")
                // TODO: Adicionar funcionalidade do toggle ligado
            } else {
                print("Weekends is off")
                // TODO: Adicionar funcionalidade do toggle desligado
            }
        }
}


// Extensão da view controller pra conformar com os protocolos UITableViewDelegate e UITableViewDataSource
extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = options[indexPath.row]
        
        // Toggle switch
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = false // Toggle state
        toggleSwitch.tag = indexPath.row // Identifica a coluna do toggle
        toggleSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        cell.accessoryView = toggleSwitch
        
        return cell
    }
    
    @objc func switchToggled(_ sender : UISwitch) {
        // TODO: Adicionar lógica para cada toggle
        if sender.tag == 0 && sender.isOn == true {
            print("sender \(sender.tag) is on")
            //scheduleWaterNotification()
        } else if sender.tag == 1 && sender.isOn == true {
            print("sender \(sender.tag) is on")
            //scheduleStretchNotification()
        } else if sender.tag == 2 && sender.isOn == true {
            print("sender \(sender.tag) is on")
            //scheduleWalkNotification()
        } else {
            print("sender is off")
        }
    }
}
