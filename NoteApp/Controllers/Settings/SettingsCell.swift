//
//  SettingsCell.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import UIKit

enum SettingsType {
    case withRightBtn
    case withSwitch
    case usual
}

protocol SettingsCellDelegate: AnyObject {
    func didSwitchOn(isOn: Bool)
}

class SettingsCell: UITableViewCell {
    
    weak var delegate: SettingsCellDelegate?
    
    private lazy var logoImage = MakerView.shared.makerImage()
    private lazy var titleLabel = MakerView.shared.makeLabel(font: Fonts.regular.size(17))
    private lazy var actionButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("English", for: .normal)
        view.setTitleColor(.lightGray, for: .normal)
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.tintColor = .black
        view.semanticContentAttribute = .forceRightToLeft
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private lazy var modeSwitch: UISwitch = {
        let view = UISwitch()
        let isOn = UserDefaults.standard.bool(forKey: "isDarkTheme")
        view.isOn = isOn
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
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
        
        contentView.addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
        actionButton.addTarget(self, action: #selector(actionBtnTapped), for: .touchUpInside)
        
        contentView.addSubview(modeSwitch)
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modeSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            modeSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            modeSwitch.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setup(settings: Setting) {
        logoImage.image = settings.logo
        logoImage.tintColor = .black
        titleLabel.text = settings.title
        if settings.type == .withRightBtn {
            modeSwitch.isHidden = true
        } else if settings.type == .withSwitch {
            actionButton.isHidden = true
        } else if settings.type == .usual {
            modeSwitch.isHidden = true
            actionButton.isHidden = true
        }
    }
    
    @objc func switchTapped() {
        delegate?.didSwitchOn(isOn: modeSwitch.isOn)
    }
    
    @objc func actionBtnTapped() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
