//
//  HomeModel.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import Foundation
import UIKit

protocol HomeModelProtocol {
    func getNotes()
}

class HomeModel: HomeModelProtocol {
    
    weak var controller: HomeControllerProtocol?
    
    private let coredataService = CoreDataService.shared
    
    var notes: [Notes] = []
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    func getNotes() {
        notes = coredataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
}
