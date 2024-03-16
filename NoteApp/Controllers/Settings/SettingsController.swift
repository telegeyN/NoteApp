//
//  SettingsController.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import Foundation

protocol SettingsControllerProtocol {
    func onGetSets()
    
    func onSuccessSets(settings: [Setting])
}

class SettingsController: SettingsControllerProtocol {
    
    private var model: SettingsModelProtocol?
    private var view: SettingsViewProtocol?
    
    init(view: SettingsViewProtocol) {
        self.model = SettingsModel(controller: self)
        self.view = view
    }
    
    func onGetSets() {
        model?.getSets()
    }
    
    func onSuccessSets(settings: [Setting]) {
        view?.successSets(settings: settings)
        
    }
}
