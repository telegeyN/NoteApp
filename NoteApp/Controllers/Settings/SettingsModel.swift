//
//  SettingsModel.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import Foundation
import UIKit

protocol SettingsModelProtocol {
    func getSets()
}

class SettingsModel: SettingsModelProtocol {
    
    var controller: SettingsControllerProtocol?
    
    var settings: [Setting] = [
        Setting(logo: UIImage(systemName: "globe"), title: "Language", actionNeeded: true, switchNeeded: false),
        Setting(logo: UIImage(systemName: "moon"), title: "Night Shift", actionNeeded: false, switchNeeded: true),
        Setting(logo: UIImage(systemName: "trash"), title: "Clear Data", actionNeeded: false, switchNeeded: false)
    ]
    
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
    
    func getSets() {
        controller?.onSuccessSets(settings: settings)
    }
    
}
