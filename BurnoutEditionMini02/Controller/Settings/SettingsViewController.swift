//
//  SettingsModalViewController.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 26/09/23.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView1 = UITableView()
    let tableView2 = UITableView()
    let settingsItems1 = ["notifications".localized, "preferences".localized, "onboarding".localized]
    let settingsItems2 = ["about".localized, "privacy".localized, "contact".localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        let label1 = UILabel()
        label1.text = "settings".localized
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.view.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "application".localized
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.view.addSubview(label2)
        
        
        let cellHeight: CGFloat = 44
        let totalRowsHeight1 = cellHeight * CGFloat(settingsItems1.count)
        let totalRowsHeight2 = cellHeight * CGFloat(settingsItems2.count)
        
        setupTableView(tableView: tableView1, items: settingsItems1, yPosition: 60, totalRowsHeight: totalRowsHeight1)
        setupTableView(tableView: tableView2, items: settingsItems2, yPosition: 60 + totalRowsHeight1 + 20, totalRowsHeight: totalRowsHeight2)
        
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        let versionLabel = UILabel()
        versionLabel.text = "\("version".localized) \(version ?? "1.0.0")"
        versionLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        versionLabel.textColor = .gray
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(versionLabel)
        
        NSLayoutConstraint.activate([
            label1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            label1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            
            tableView1.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 10), // Changed from titleLabel to label1
            tableView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            tableView1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            tableView1.heightAnchor.constraint(equalToConstant: totalRowsHeight1),
            
            label2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            label2.topAnchor.constraint(equalTo: tableView1.bottomAnchor, constant: 30),
            
            tableView2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 10), // Changed from tableView1 to label2
            tableView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            tableView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            tableView2.heightAnchor.constraint(equalToConstant: totalRowsHeight2),
            
            versionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            versionLabel.topAnchor.constraint(equalTo: tableView2.bottomAnchor, constant: 40)
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
        return (tableView == self.tableView1) ? settingsItems1.count : settingsItems2.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if (tableView == self.tableView1) {
            cell.textLabel?.text = settingsItems1[indexPath.section]
        } else if (tableView == self.tableView2) {
            cell.textLabel?.text = settingsItems2[indexPath.section]
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == self.tableView1) {
            switch indexPath.section {
            case 0:
                let notificationsVC = NotificationsViewController()
                self.navigationController?.pushViewController(notificationsVC, animated: true)
            case 1:
                print("PREFERENCES")
                let preferencesVC = PreferencesViewController()
                self.navigationController?.pushViewController(preferencesVC, animated: true)
            case 2:
                print("ONBOARDING")
                //TODO: adicionar onboarding
                // let onboardingVC = OnboardingViewController()
                //self.navigationController?.pushViewController(onboardingVC, animated: true)
            default:
                break
            }
            
        } else if (tableView == self.tableView2) {
            switch indexPath.section {
            case 0:
                let acknowledgementsVC = AcknowledgementsViewController()
                self.navigationController?.pushViewController(acknowledgementsVC, animated: true)
            case 1:
                let privacyVC = PrivacyViewController()
                self.navigationController?.pushViewController(privacyVC, animated: true)
            case 2:
                print("CONTACT US")
                //TODO: adicionar contact us
                //let contactUsVC = ContactUsViewController()
                //self.navigationController?.pushViewController(contactUsVC, animated:true)
            default:
                break
            }
            
        }
        
    }
}
