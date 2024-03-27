//
//  AddView.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 27/03/24.
//

import UIKit

class AddNoteView: UIViewController {
    
    private let coreDataService = CoreDataService.shared
    
    private lazy var titleTF = MakerView.shared.makeTextField(placeholder: "Title",cornerRadius: 34/2, backgroundColor: .clear, borderWidth: 1)
    private lazy var noteTV = MakerView.shared.makeTextView(cornerRadius: 34/2)
    private lazy var saveButton = MakerView.shared.makeSimpleButton(title: "Save",titleFont: Fonts.bold.size(14), cornerRadius: 42/2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavItem()
        setupConstraints()
    }
    
    
    private func setupNavItem() {
        navigationItem.title = "New Note"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashButtonTapped))
        settingsBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = settingsBarButtonItem
    }
    
    @objc func trashButtonTapped() {
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(titleTF)
        NSLayoutConstraint.activate([
            titleTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            titleTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            titleTF.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            saveButton.heightAnchor.constraint(equalToConstant: 42)
        ])
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        view.addSubview(noteTV)
        NSLayoutConstraint.activate([
            noteTV.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 26),
            noteTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            noteTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            noteTV.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -26) 
        ])
    
    }
    
    @objc func saveButtonTapped() {
        let id = UUID().uuidString
        let date = Date()
        coreDataService.addNote(id: id, title: titleTF.text ?? "", description: noteTV.text ?? "", date: date)
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


