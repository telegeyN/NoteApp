//
//  OnboardingController.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 20/03/24.
//

import Foundation

protocol OnboardingControllerProtocol: AnyObject {
    func onGetOnboardingDetails()
    
    func onSuccessOnboardingDetails(details: [Detail])
}

class OnboardingController: OnboardingControllerProtocol {
    
    private var model: OnboardingModelProtocol?
    weak var view: OnboardingViewProtocol?
    
    init(view: OnboardingViewProtocol) {
        self.model = OnboardingModel(controller: self)
        self.view = view
    }
    
    func onGetOnboardingDetails() {
        model?.getOnboardingDetails()
    }
    
    func onSuccessOnboardingDetails(details: [Detail]) {
        view?.successOnboardingDetails(details: details)
        
    }
}
