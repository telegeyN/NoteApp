//
//  SettingsView.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func successSettings(settings: [Setting])
}

class SettingsView: UIViewController {
    
    private var settings: [Setting] = []
    private var controller: SettingsControllerProtocol?
    
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = SettingsController(view: self)

        view.backgroundColor = .systemBackground
        setupNavItem()
        setupConstraints()
        controller?.onGetSettings()
    }
    
    private func setupNavItem() {
        navigationItem.title = "Settings"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = settingsBarButtonItem
    }
    
    @objc func settingsButtonTapped() {
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
    }
    
}
    
extension SettingsView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
        cell.setup(settings: settings[indexPath.row])
        return cell
    }
}

extension SettingsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SettingsView: SettingsViewProtocol{
    
    func successSettings(settings: [Setting]){
        self.settings = settings
        tableView.reloadData()
    }

}
