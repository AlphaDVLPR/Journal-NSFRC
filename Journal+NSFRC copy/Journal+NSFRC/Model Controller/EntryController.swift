//
//  EntryController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedInstance = EntryController()
    
    var fetchResultsController: NSFetchedResultsController<Entry>
    
//THIS IS FETCH REQUEST
    
//    /// entries is a computed property. Its getting its alue from the results of a NSFetchRequest. The <Model> defines thegeneric type. This ensures that our entries array can ONLY hold entry objects
//
//    var entries: [Entry] {
//        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
//        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
//    }
    
//THIS IS NS FETCH RESULT CONTROLLER
    
    init () {
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController = resultsController
        
        do {
    
        try fetchResultsController.performFetch()
            
        } catch {
            
            print("There was an error perfomring the fetch! \(#function) \(error.localizedDescription)")
            
        }
    }
        
    
    
    //CRUD
    
    ///WE DEFINE A createENTRY METHOD THAT TAKES IN TWO STRINGS: TITLE AND BODY. THEN WE ARE USING THE CONVIENCE INIT WE EXTENDED THE ENTRY CLASS WITH AND PASS IN THOSE STRINGS. THIS CREATES OUR ENTRY OBJECTS WITH ALL REQUIRED DATA
    
    func createEntry(withTitle: String, withBody: String) {
        let _ = Entry(title: withTitle, body: withBody)
        
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        
        saveToPersistentStore()
    }
    
    func deleteEntry(entry: Entry) {
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStore()
    }
    
    ///WE ARE ATTEMPTING TO SAVE ALL OUR ENTRIES TO OUR COREDATASTACKS PERSISTENT STORE
    
    func saveToPersistentStore() {
        do {
             try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object. Items not saved!! \(#function) : \(error.localizedDescription)")
        }
    }
}

