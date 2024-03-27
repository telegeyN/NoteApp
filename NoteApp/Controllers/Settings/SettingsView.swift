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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateButtonColors()
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
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor/*, constant: 12*/),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor/*, constant: -12*/),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func updateButtonColors() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            navigationItem.leftBarButtonItem?.tintColor = .white
            navigationItem.rightBarButtonItem?.tintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationItem.leftBarButtonItem?.tintColor = .black
            navigationItem.rightBarButtonItem?.tintColor = .black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }
    
}
    
extension SettingsView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
        cell.delegate = self
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

extension SettingsView: SettingsCellDelegate {
    
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.setValue(isOn, forKey: "isDarkTheme")
        updateButtonColors()
        if isOn == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}
