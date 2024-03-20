//
//  HomeController.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 16/03/24.
//

import Foundation

protocol HomeControllerProtocol: AnyObject {
    func onGetNotes()
    
    func onSuccessNotes(notes: [Note])
}

class HomeController: HomeControllerProtocol {
    
    private var model: HomeModelProtocol?
    weak var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol) {
        self.model = HomeModel(controller: self)
        self.view = view
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccessNotes(notes: [Note]) {
        view?.successNotes(notes: notes)
        
    }
}
