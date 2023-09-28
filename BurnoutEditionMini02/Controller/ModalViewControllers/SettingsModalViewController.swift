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
    var workStartPicker: UIDatePicker!
    var workEndPicker: UIDatePicker!
    var includeWeekendsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // Define a cor de fundo da view como branco
        navigationItem.title = "settings".localized
        
        let workScheduleLabel = UILabel()
        workScheduleLabel.text = "Set your work schedule:"
        
        let startLabel = UILabel()
        startLabel.text = "Start"
        
        let endLabel = UILabel()
        endLabel.text = "End"
        
        workStartPicker = UIDatePicker()
        workStartPicker.datePickerMode = .time
        
        workEndPicker = UIDatePicker()
        workEndPicker.datePickerMode = .time
        
        let reminderLabel = UILabel()
        reminderLabel.text = "Select what you would like to be reminded:"
        
        tableView = UITableView()
        
        view.addSubview(workScheduleLabel)
        view.addSubview(startLabel)
        view.addSubview(workStartPicker)
        view.addSubview(endLabel)
        view.addSubview(workEndPicker)
        view.addSubview(reminderLabel)
        view.addSubview(tableView)
        
        // Constraints
        workScheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workScheduleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            workScheduleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            workScheduleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: workScheduleLabel.bottomAnchor, constant: 20), // vertical
            startLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            startLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        workStartPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workStartPicker.centerYAnchor.constraint(equalTo: startLabel.centerYAnchor),
            workStartPicker.leadingAnchor.constraint(equalTo: startLabel.trailingAnchor, constant: 10),
            workStartPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        endLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            endLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 20), // vertical
            endLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            endLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        workEndPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workEndPicker.centerYAnchor.constraint(equalTo: endLabel.centerYAnchor),
            workEndPicker.leadingAnchor.constraint(equalTo: endLabel.trailingAnchor, constant: 10),
            workEndPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        
        includeWeekendsSwitch = UISwitch()
        includeWeekendsSwitch.isOn = false // default: off
        
        let includeWeekendsLabel = UILabel()
        includeWeekendsLabel.text = "Include weekends:"
        
        view.addSubview(includeWeekendsLabel)
        view.addSubview(includeWeekendsSwitch)
        
        
        // Constraints para incluir finais de semana
        includeWeekendsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            includeWeekendsLabel.topAnchor.constraint(equalTo: workEndPicker.bottomAnchor, constant: 20),
            includeWeekendsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            includeWeekendsLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        includeWeekendsSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            includeWeekendsSwitch.centerYAnchor.constraint(equalTo: includeWeekendsLabel.centerYAnchor),
            includeWeekendsSwitch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
        
        // Constraints pro label da seção de lembretes
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reminderLabel.topAnchor.constraint(equalTo: includeWeekendsSwitch.bottomAnchor, constant: 20),
            reminderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            reminderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        // Inicializa a tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Constraints da table view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// Extensão da view controller pra conformar com os protocolos UITableViewDelegate e UITableViewDataSource
extension SettingsModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = options[indexPath.row]
        
        // Toggle switch
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = true // Toggle state
        toggleSwitch.tag = indexPath.row // Identifica a coluna do toggle
        toggleSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        cell.accessoryView = toggleSwitch
        
        return cell
    }
    
    @objc func switchToggled(_ sender : UISwitch) {
        print("Switch in row \(sender.tag) is \(sender.isOn ? "ON" : "OFF")")
        
        // TODO: Adicionar lógica para os toggles
    }
}
