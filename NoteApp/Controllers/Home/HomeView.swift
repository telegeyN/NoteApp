//
//  ViewController.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func successNotes(notes: [Notes])
}

class HomeView: UIViewController {
    
    private var notes: [Notes] = []
    private var controller: HomeControllerProtocol?
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.backgroundImage = UIImage()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var notesLabel = MakerView.shared.makeLabel(text: "Notes")
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 60) / 2 , height: 100)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var addButton = MakerView.shared.makeSimpleButton(title: "+",titleFont: Fonts.light.size(28), cornerRadius: 42/2)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        controller = HomeController(view: self)
        
        view.backgroundColor = .systemBackground
        setupNavItem()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        controller?.onGetNotes()
        updateButtonColors()
    }
    
    private func setupNavItem() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Main"
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        
    }
    
    @objc func settingsButtonTapped() {
        let vc = SettingsView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraints() {
        
        view.addSubview(noteSearchBar)
        NSLayoutConstraint.activate([
            noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            noteSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            noteSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            noteSearchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        view.addSubview(notesLabel)
        NSLayoutConstraint.activate([
            notesLabel.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 32),
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 49)
        ])
        
        view.addSubview(notesCollectionView)
        NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor,constant: 40),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 24),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -24),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        notesCollectionView.dataSource = self
        notesCollectionView.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 42),
            addButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        let vc = AddNoteView()
        navigationController?.pushViewController(vc, animated: true)
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

extension HomeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        cell.setup(title: notes[indexPath.row].title ?? "")
        return cell
    }
    
}

extension HomeView: HomeViewProtocol{
    
    func successNotes(notes: [Notes]){
        self.notes = notes
        notesCollectionView.reloadData()
    }
}

