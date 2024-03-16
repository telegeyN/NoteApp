//
//  SettingsCell.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    private lazy var logoImage = MakerView.shared.makerImage()
    private lazy var titleLabel = MakerView.shared.makeLabel(font: Fonts.regular.size(17))
    private lazy var actionButton = UIButton(type: .system)
    private lazy var modeSwitch = UISwitch()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .init(hex: "#EEEEEF")
    }
    
    private func setupConstraints(){
        
        contentView.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            logoImage.heightAnchor.constraint(equalToConstant: 22),
            logoImage.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 16)
        ])
    }
    
    func setup(settings: Setting) {
        logoImage.image = settings.logo
        logoImage.tintColor = .black
        titleLabel.text = settings.title
        if settings.actionNeeded {
            setupActionButton()
        }
        if settings.switchNeeded {
            setupModeSwitch()
        }
    }

    private func setupActionButton() {
        actionButton.setTitle("English", for: .normal)
        actionButton.setTitleColor(.lightGray, for: .normal)
        actionButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        actionButton.tintColor = .black
        actionButton.semanticContentAttribute = .forceRightToLeft
        contentView.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    private func setupModeSwitch() {
        contentView.addSubview(modeSwitch)
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modeSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            modeSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            modeSwitch.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
