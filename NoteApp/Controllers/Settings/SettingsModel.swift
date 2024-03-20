//
//  SettingsModel.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import Foundation
import UIKit

protocol SettingsModelProtocol {
    func getSettings()
}

class SettingsModel: SettingsModelProtocol {
    
    weak var controller: SettingsControllerProtocol?
    
    var settings: [Setting] = [
        Setting(logo: UIImage(systemName: "globe"), title: "Language", type: .withRightBtn),
        Setting(logo: UIImage(systemName: "moon"), title: "Night Shift", type: .withSwitch),
        Setting(logo: UIImage(systemName: "trash"), title: "Clear Data", type: .usual)
    ]
    
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
    
    func getSettings() {
        controller?.onSuccessSettings(settings: settings)
    }
    
}
