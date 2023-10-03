//
//  ReflectionViewController.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 21/09/23.
//

import UIKit

class ReflectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Variáveis
    // SearchBar
    let searchBar = UISearchBar()
    
    // TableView
    var reflections: [ReflectionModel] = []
    let tableView = UITableView()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cor de fundo da View
        view.backgroundColor = .systemBackground
        self.title = "Reflection"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        reflections = fetchData()
        
        // Funções setup
        setupSearchBar()
        setupTableView()
        
        // Constraints
        constraints()
    }
    
    // MARK: - TableView
    private func setupTableView() {
        // Adicionando à view
        view.addSubview(tableView)
        
        // Configurando os delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Estilo do separador
        tableView.separatorStyle = .none
        
        // Registrando as cells
        tableView.register(NewReflectionTableViewCell.self, forCellReuseIdentifier: "newRefCell")
        tableView.register(ReflectionTableViewCell.self, forCellReuseIdentifier: "refCell")
    }
    
    // Número de seções da tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Número de rows por cada section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // Caso seja a primeira seção, retorna 1
            return 1
        } else {          // De resto, retorna o número de reflections
            return reflections.count
        }
    }
    
    // Célula de cada row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "newRefCell") as! NewReflectionTableViewCell
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "refCell") as! ReflectionTableViewCell
            let reflection = reflections[indexPath.row]
            cell.set(reflection: reflection)
            
            return cell
        }
    }
    
    // Altura das rows de cada section
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return view.frame.height / 5
        } else {
            return view.frame.height / 7.5
        }
    }
    
    // MARK: - Search bar
    func setupSearchBar() {
        // Configuracões da Search Bar
        searchBar.placeholder = "Search"
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.searchBarStyle = .prominent
        
        view.addSubview(searchBar)
    }
    
    // MARK: - Constraints
    private func constraints() {
        // Search Bar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width - 16)
        ])
        
        // TableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - DUMMY DATA TESTE (SEÇÃO 2 DA TABLEVIEW ESTÁ PUXANDO OS DADOS DAQUI)
extension ReflectionViewController {
    
    func fetchData() -> [ReflectionModel] {
        let id = UUID()
        let id2 = UUID()
        let testeGoal = GoalStatic(id: id, title: "título teste")
        let teste = ReflectionModel(id: id2, name: "Minha reflection", relatedGoal: testeGoal, randomRefQst: "fodase??", randomRefAns: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam pellentesque erat vel sem cursus auctor. Nulla tincidunt eu libero sit amet bibendum. Fusce at sapien", draw: nil, mood: "😃", date: "29 SET")
        
        return [teste, teste, teste, teste, teste]
    }
}
