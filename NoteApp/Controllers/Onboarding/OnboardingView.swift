//
//  OnboardingView.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 20/03/24.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func successOnboardingDetails (details: [Detail])
}

protocol OnboardingViewDelegate: AnyObject {
    func hasBeenShown(beenShown: Bool)
}

class OnboardingView: UIViewController {
    
    weak var delegate: OnboardingViewDelegate?
    private var details: [Detail] = []
    private var controller: OnboardingControllerProtocol?
    
    private lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 80) , height: 319)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = true
        cv.clipsToBounds = false
        return cv
    }()
    
    private lazy var skipButton = MakerView.shared.makeSimpleButton(backgroundColor: .clear, title: "Skip",titleColor: .init(hex: "#FF3D3D") ,titleFont: Fonts.regular.size(16))
    
    private lazy var nextButton = MakerView.shared.makeSimpleButton(title: "Next",titleFont: Fonts.regular.size(16), cornerRadius: 22)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        controller = OnboardingController(view: self)
        setupConstraints()
        controller?.onGetOnboardingDetails()
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
    
    private func setupConstraints() {
        
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -134),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipButton.heightAnchor.constraint(equalToConstant: 42),
            skipButton.widthAnchor.constraint(equalToConstant: 173)
        ])
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -134),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 42),
            nextButton.widthAnchor.constraint(equalToConstant: 173)
        ])
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(onboardingCollectionView)
        NSLayoutConstraint.activate([
            onboardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 190),
            onboardingCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -40),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -12)
        ])
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.reuseId)
    }
    
    @objc private func skipButtonTapped() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
        delegate = self
        delegate?.hasBeenShown(beenShown: true)
    }
    
    @objc private func nextButtonTapped() {
        guard !details.isEmpty else { return }
        guard let visibleIndexPath = onboardingCollectionView.indexPathsForVisibleItems.first else { return }
        if visibleIndexPath.item == details.count - 1 {
            let vc = HomeView()
            navigationController?.pushViewController(vc, animated: true)
            delegate?.hasBeenShown(beenShown: true)
        } else {
            let nextIndexPath = IndexPath(item: visibleIndexPath.item + 1, section: visibleIndexPath.section)
            onboardingCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.reuseId, for: indexPath) as! OnboardingCell
        cell.setup(details: details[indexPath.row])
        return cell
    }
}

extension OnboardingView: OnboardingViewProtocol{
    
    func successOnboardingDetails(details: [Detail]){
        self.details = details
        onboardingCollectionView.reloadData()
    }
}

extension OnboardingView: OnboardingViewDelegate {
    func hasBeenShown(beenShown: Bool) {
        UserDefaults.standard.setValue(beenShown, forKey: "isOnBoardBeenShown")
    }
}
