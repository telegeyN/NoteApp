//
//  OnboardingModel.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 20/03/24.
//

import Foundation
import UIKit

protocol OnboardingModelProtocol {
    func getOnboardingDetails()
}

class OnboardingModel: OnboardingModelProtocol {
    
    weak var controller: OnboardingControllerProtocol?
    
    var details: [Detail] = [
        Detail(image: UIImage(named: "first"), title: "Welcome to The Note", description: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!"),
        Detail(image: UIImage(named: "second"), title: "Set Up Your Profile", description: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
        Detail(image: UIImage(named: "third"), title: "Dive into The Note", description: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")
    ]
    
    init(controller: OnboardingControllerProtocol) {
        self.controller = controller
    }
    
    func getOnboardingDetails() {
        controller?.onSuccessOnboardingDetails(details: details)
    }
}
