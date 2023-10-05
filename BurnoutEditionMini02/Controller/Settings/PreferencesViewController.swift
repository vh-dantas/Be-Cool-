//
//  PreferencesViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 05/10/23.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    var workStartPicker: UIDatePicker!
    var workEndPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewStyle()
        setupWorkSchedule()
        loadWorkSchedule()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveWorkSchedule()
    }
    
    // MARK: -- SETUP VISUAL DA VIEW
    func setupViewStyle() {
        view.backgroundColor = .white
        navigationItem.title = "notifications".localized
    }
    
    
    // MARK: -- SETUP DO HORÁRIO DE TRABALHO
    func setupWorkSchedule() {
        // Label
        let workScheduleLabel = UILabel()
        let startLabel = UILabel()
        let endLabel = UILabel()
        
        // Horário default de entrada
        let defaultTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())
        // Horário default de saída
        let defaultLeaveTime = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())
        
        workScheduleLabel.text = "Set your work schedule:"
        startLabel.text = "Start"
        endLabel.text = "End"
        
        // Pickers do tipo .time
        workStartPicker = UIDatePicker()
        workStartPicker.date = defaultTime ?? Date()
        workStartPicker.datePickerMode = .time
        
        workEndPicker = UIDatePicker()
        workEndPicker.date = defaultLeaveTime ?? Date()
        workEndPicker.datePickerMode = .time
        
        // Adiciona os componentes na view
        view.addSubview(workScheduleLabel)
        view.addSubview(startLabel)
        view.addSubview(endLabel)
        view.addSubview(workStartPicker)
        view.addSubview(workEndPicker)
        
        // Constraints das labels
        workScheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        endLabel.translatesAutoresizingMaskIntoConstraints = false
        workStartPicker.translatesAutoresizingMaskIntoConstraints = false
        workEndPicker.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraint: Defina o horário de trabalho
        NSLayoutConstraint.activate([
            workScheduleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            workScheduleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            workScheduleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            startLabel.topAnchor.constraint(equalTo: workScheduleLabel.bottomAnchor, constant: 20), // vertical
            startLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            startLabel.widthAnchor.constraint(equalToConstant: 50),

            endLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 20), // vertical
            endLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            endLabel.widthAnchor.constraint(equalToConstant: 50),

            workStartPicker.centerYAnchor.constraint(equalTo: startLabel.centerYAnchor),
            workStartPicker.leadingAnchor.constraint(equalTo: startLabel.trailingAnchor, constant: 10),
            workStartPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            workEndPicker.centerYAnchor.constraint(equalTo: endLabel.centerYAnchor),
            workEndPicker.leadingAnchor.constraint(equalTo: endLabel.trailingAnchor, constant: 10),
            workEndPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    func saveWorkSchedule() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        let workStartTime = dateFormatter.string(from: workStartPicker.date)
        let workEndTime = dateFormatter.string(from: workEndPicker.date)
        
        UserDefaults.standard.set(workStartTime, forKey: "workStartTime")
        UserDefaults.standard.set(workEndTime, forKey: "workEndTime")
    }
    
    func loadWorkSchedule() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short

        if let workStartTimeString = UserDefaults.standard.string(forKey: "workStartTime"),
           let workEndTimeString = UserDefaults.standard.string(forKey: "workEndTime"),
           let workStartTime = dateFormatter.date(from: workStartTimeString),
           let workEndTime = dateFormatter.date(from: workEndTimeString) {
            workStartPicker.date = workStartTime
            workEndPicker.date = workEndTime
        }
    }
}
