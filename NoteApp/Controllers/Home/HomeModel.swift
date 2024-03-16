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
    
    var controller: HomeControllerProtocol?
    
    var notes: [Note] = [
        Note(title: "School notes", bgColor: .init(hex: "#D9BBF9")),
        Note(title: "Funny jokes", bgColor: .init(hex: "#D7F7F2")),
        Note(title: "Travel bucket list", bgColor: .init(hex: "#D7EDF8")),
        Note(title: "Random cooking ideas", bgColor: .init(hex: "#FFF5E1"))
    ]
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
}
