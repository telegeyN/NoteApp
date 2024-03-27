//
//  AddNoteGroup.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 27/03/24.
//

import Foundation

protocol AddNoteModelProtocol: AnyObject {
    func addNote(title: String, description: String)
}
class AddNoteModel: AddNoteModelProtocol {

    weak var controller: AddNoteControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: AddNoteControllerProtocol) {
        self.controller = controller
    }
    
    func addNote(title: String, description: String) {
        let id = UUID().uuidString
        let date = Date()
        coreDataService.addNote(id: id, title: title, description: description, date: date)
    }
}
