//
//  Fonts.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import UIKit

enum Fonts: String {
    case bold = "Inter-Bold"
    case regular = "Inter-Regular"
    case light = "Inter-Light"
    
    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: rawValue, size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

