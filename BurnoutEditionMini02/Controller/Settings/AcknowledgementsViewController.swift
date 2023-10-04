//
//  AcknowledgementsViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 01/10/23.
//

import UIKit

class AcknowledgementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView1 = UITableView()
    let tableView2 = UITableView()
    let tableView3 = UITableView()
    let devs = ["Amanda", "João", "Mirelle", "Thayná", "Victor Hugo"]
    let experts = ["Edlane", "Nathali"]
    let mentors = ["Jair Barbosa", "Julio Santos", "Felipe Carvalho"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        let titleLabel = UILabel()
        titleLabel.text = "about".localized
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.view.addSubview(titleLabel)
        
        let cellHeight: CGFloat = 44
        let totalRowsHeight1 = cellHeight * CGFloat(devs.count)
        let totalRowsHeight2 = cellHeight * CGFloat(experts.count)
        let totalRowsHeight3 = cellHeight * CGFloat(mentors.count)
        
        setupTableView(tableView: tableView1, items: devs, yPosition: 60, totalRowsHeight: totalRowsHeight1)
        setupTableView(tableView: tableView2, items: experts, yPosition: 60 + totalRowsHeight1 + 20, totalRowsHeight: totalRowsHeight2)
        setupTableView(tableView: tableView3, items: mentors, yPosition: 60 + totalRowsHeight2 + 20, totalRowsHeight: totalRowsHeight3)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            
            tableView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            tableView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            tableView1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            tableView1.heightAnchor.constraint(equalToConstant: totalRowsHeight1),
            
            tableView2.topAnchor.constraint(equalTo: tableView1.bottomAnchor, constant: 20),
            tableView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            tableView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            tableView2.heightAnchor.constraint(equalToConstant: totalRowsHeight2),
            
            tableView3.topAnchor.constraint(equalTo: tableView2.bottomAnchor, constant: 20),
            tableView3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            tableView3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            tableView3.heightAnchor.constraint(equalToConstant: totalRowsHeight3),
        ])
    }
    
    func setupTableView(tableView: UITableView, items: [String], yPosition: CGFloat, totalRowsHeight: CGFloat) {
        tableView.frame = CGRect(x: 10, y: yPosition, width: self.view.bounds.width - 20, height: totalRowsHeight)
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView1 {
            return devs.count
        } else if tableView == self.tableView2 {
            return experts.count
        } else if tableView == self.tableView3 {
            return mentors.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if (tableView == self.tableView1) {
            cell.textLabel?.text = devs[indexPath.section]
        } else if (tableView == self.tableView2) {
            cell.textLabel?.text = experts[indexPath.section]
        } else if (tableView == self.tableView3) {
            cell.textLabel?.text = mentors[indexPath.section]
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
