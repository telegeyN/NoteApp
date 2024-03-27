//
//  CoreDataService.swift
//  NoteApp
//
//  Created by Telegey Nurbekova on 27/03/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataService: NSObject {
    static let shared = CoreDataService()
    
    private override init() {
        
    }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func addNote(id: String, title: String, description: String, date: Date) {
        guard let noteEntity = NSEntityDescription.entity(forEntityName: "Notes", in: context) else { return }
        
        let note = Notes(entity: noteEntity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        
        appDelegate.saveContext()
    }
    
    func fetchNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        do {
            return try context.fetch(fetchRequest) as! [Notes]
        } catch {
            print(error.localizedDescription)
        }
        return  []
    }
}
