//
//  MakerView.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import UIKit

final class MakerView {
    
    static let shared = MakerView()
    
    private init(){
        print("init MakerView")
    }
    
    func makeLabel(text: String = "",
                   font: UIFont = Fonts.regular.size(16),
                   textColor: UIColor = .black,
                   backgroundColor: UIColor = .clear,
                   textAlignment: NSTextAlignment = .left,
                   numberOfLines: Int = 0,
                   lineBreakMode:NSLineBreakMode = .byWordWrapping,
                   translatesAutoresizingMaskIntoConstraints: Bool = false
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return label
    }
    
    func makeSimpleButton(backgroundColor: UIColor = .init(hex: "#FF3D3D"),
                          title: String = "",
                          titleColor: UIColor = .white,
                          titleFont: UIFont = Fonts.bold.size(14),
                          cornerRadius: CGFloat = 0,
                          translatesAutoresizingMaskIntoConstraints: Bool = false
    ) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = titleFont
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return button
    }
    
    func makerImage(imageName: String = "",
                    translatesAutoresizingMaskIntoConstraints: Bool = false
    ) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(systemName: imageName)
        image.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return image
    }
    
    func makeTextField(text: String = "",
                       placeholder: String = "",
                       cornerRadius: CGFloat = 12,
                       textColor: UIColor = .black,
                       backgroundColor: UIColor = .init(hex: "#EEEEEF"),
                       borderColor: UIColor = .black,
                       borderWidth: CGFloat = 0,
                       placeholderColor: UIColor = .init(hex: "#A5A5A5"),
                       placeholderFont: UIFont = Fonts.regular.size(17),
                       translatesAutoresizingMaskIntoConstraints: Bool = false
    ) -> UITextField {
        let tf = UITextField()
        tf.text = text
        tf.placeholder = placeholder
        tf.layer.cornerRadius = cornerRadius
        tf.backgroundColor = backgroundColor
        tf.layer.borderColor = borderColor.cgColor
        tf.layer.borderWidth = borderWidth
        tf.textColor = textColor
        tf.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: placeholderFont
        ]
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 8))
        tf.leftView = view
        tf.leftViewMode = .always
        
        return tf
    }
    
    func makeTextView(text: String = "",
                                placeholder: String = "",
                                cornerRadius: CGFloat = 12,
                                textColor: UIColor = .black,
                                backgroundColor: UIColor = .init(hex: "#EEEEEF"),
                                borderColor: UIColor = .black,
                                borderWidth: CGFloat = 0,
                                placeholderColor: UIColor = .init(hex: "#A5A5A5"),
                                placeholderFont: UIFont = Fonts.regular.size(17),
                                translatesAutoresizingMaskIntoConstraints: Bool = false
    ) -> UITextView {
        let textView = UITextView()
        textView.text = text
        textView.font = placeholderFont
        textView.textColor = textColor
        textView.backgroundColor = backgroundColor
        textView.layer.cornerRadius = cornerRadius
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.borderWidth = borderWidth
        textView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        return textView
    }

    
    
}
