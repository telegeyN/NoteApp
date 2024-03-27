//
//  SettingsController.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import Foundation

protocol SettingsControllerProtocol: AnyObject {
    
    func onGetSettings()
    
    func onSuccessSettings(settings: [Setting])
}

class SettingsController: SettingsControllerProtocol {
    
    private var model: SettingsModelProtocol?
    weak var view: SettingsViewProtocol?
    
    init(view: SettingsViewProtocol) {
        self.model = SettingsModel(controller: self)
        self.view = view
    }
    
    func onGetSettings() {
        model?.getSettings()
    }
    
    func onSuccessSettings(settings: [Setting]) {
        view?.successSettings(settings: settings)
        
    }
}
