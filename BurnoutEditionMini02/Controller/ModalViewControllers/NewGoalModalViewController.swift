//
//  NewGoalModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class NewGoalModalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tasks = [String]()
    var tableView: UITableView!
    var taskTextField: UITextField!
    var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar a UITableView programaticamente
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        view.addSubview(tableView)
        
        // Configurar o campo de texto para adicionar tarefas
        taskTextField = UITextField(frame: CGRect(x: 20, y: view.bounds.height - 100, width: view.bounds.width - 120, height: 40))
        taskTextField.placeholder = "Digite uma nova tarefa"
        view.addSubview(taskTextField)
        
        // Configurar o botão para adicionar tarefas
        addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: view.bounds.width - 80, y: view.bounds.height - 100, width: 60, height: 40)
        addButton.setTitle("Adicionar", for: .normal)
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    @objc func addTask() {
        if let taskText = taskTextField.text, !taskText.isEmpty {
            tasks.append(taskText)
            taskTextField.text = ""
            tableView.reloadData()
        }
    }
}

