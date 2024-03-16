//
//  NoteCell.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    static var reuseId = "note_cell"
    
    private lazy var titleLabel = MakerView.shared.makeLabel(font: Fonts.bold.size(12))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        contentView.layer.cornerRadius = 12
    }
    
    private func setupConstraints(){
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setup(notes: Note) {
        titleLabel.text = notes.title
        contentView.backgroundColor = notes.bgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
