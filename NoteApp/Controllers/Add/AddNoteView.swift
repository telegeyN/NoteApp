//
//  AddView.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 27/03/24.
//

import UIKit

protocol AddNoteViewProtocol: AnyObject {
    
}

class AddNoteView: UIViewController {
    
    private var controller: AddNoteControllerProtocol?
    
    private lazy var titleTF = MakerView.shared.makeTextField(placeholder: "Title",cornerRadius: 34/2, backgroundColor: .white, borderWidth: 1)
    private lazy var noteTV = MakerView.shared.makeTextView(cornerRadius: 34/2)
    private lazy var saveButton = MakerView.shared.makeSimpleButton(title: "Save",titleFont: Fonts.bold.size(14), cornerRadius: 42/2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = AddNoteController(view: self)
        view.backgroundColor = .systemBackground
        setupNavItem()
        setupConstraints()
        updateSaveButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        updateButtonColors()
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
        titleTF.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)

        
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
    
    @objc private func titleTextFieldDidChange() {
        updateSaveButtonState()
    }

    
    @objc func saveButtonTapped() {
        controller?.onAddNote(title: titleTF.text ?? "", description: "description")
    }
    
    private func updateSaveButtonState() {
        if let titleText = titleTF.text, !titleText.isEmpty {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .init(hex: "#FF3D3D")
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .gray
        }
    }

    
    private func updateButtonColors() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            titleTF.layer.borderColor = UIColor.white.cgColor
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

extension AddNoteView: AddNoteViewProtocol{
    
}

