//
//  OnboardingCell.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 20/03/24.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static var reuseId = "onboarding_cell"
    
    private lazy var logoImage = MakerView.shared.makerImage()
    
    private lazy var titleLabel = MakerView.shared.makeLabel(font: Fonts.bold.size(22), textAlignment: .center)
    
    private lazy var descriptionLabel = MakerView.shared.makeLabel(font: Fonts.regular.size(14),textColor: .init(hex: "#40424C"), textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        contentView.layer.cornerRadius = 12
    }
    
    private func setupConstraints(){
        
        contentView.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 140),
            logoImage.widthAnchor.constraint(equalToConstant: 212)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3)
        ])
    }
    
    func setup(details: Detail) {
        logoImage.image = details.image
        titleLabel.text = details.title
        descriptionLabel.text = details.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

