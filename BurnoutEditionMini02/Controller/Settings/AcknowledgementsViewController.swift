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
    let devs = ["Amanda Parrini", "João Victor Bernardes", "Mirelle Sine", "Thayná Rodrigues", "Victor Hugo Dantas"]
    let experts = ["Edlane", "Nathali"]
    let mentors = ["Jair Barbosa", "Julio Santos", "Felipe Carvalho"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        // Create a UIScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        // Create a container UIView inside the scroll view
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        
        let titleLabel = UILabel()
        titleLabel.text = "about".localized
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        containerView.addSubview(titleLabel)
        
        let label1 = UILabel()
        label1.text = "team".localized
        label1.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "experts".localized
        label2.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label2)
        
        let label3 = UILabel()
        label3.text = "mentors".localized
        label3.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label3)
        
        let cellHeight: CGFloat = 44
        let totalRowsHeight1 = cellHeight * CGFloat(devs.count)
        let totalRowsHeight2 = cellHeight * CGFloat(experts.count)
        let totalRowsHeight3 = cellHeight * CGFloat(mentors.count)
        
        setupTableView(tableView: tableView1, items: devs, yPosition: 60, totalRowsHeight: totalRowsHeight1, containerView: containerView)
        setupTableView(tableView: tableView2, items: experts, yPosition: 60 + totalRowsHeight1 + 20, totalRowsHeight: totalRowsHeight2, containerView: containerView)
        setupTableView(tableView: tableView3, items: mentors, yPosition: 60 + totalRowsHeight2 + 20, totalRowsHeight: totalRowsHeight3, containerView: containerView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            
            // Set constraints for the labels
            label1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            label1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            tableView1.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 30),
            tableView1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            tableView1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            tableView1.heightAnchor.constraint(equalToConstant: totalRowsHeight1),
            
            label2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            label2.topAnchor.constraint(equalTo: tableView1.bottomAnchor, constant: 20),

            tableView2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            tableView2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            tableView2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            tableView2.heightAnchor.constraint(equalToConstant: totalRowsHeight2),
            
            label3.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            label3.topAnchor.constraint(equalTo: tableView2.bottomAnchor, constant: 20),

            tableView3.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 20),
            tableView3.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            tableView3.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            tableView3.heightAnchor.constraint(equalToConstant: totalRowsHeight3),
            
            // Set constraints for scrollView and containerView
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: tableView3.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Set scrollView content size
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20) // Adjust this constant as needed
        ])
    }
    
    func setupTableView(tableView: UITableView, items: [String], yPosition: CGFloat, totalRowsHeight: CGFloat, containerView: UIView) {
        tableView.frame = CGRect(x: 10, y: yPosition, width: containerView.bounds.width - 20, height: totalRowsHeight)
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tableView)
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
