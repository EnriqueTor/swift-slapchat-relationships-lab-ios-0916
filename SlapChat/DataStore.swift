//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var messages:[Message] = []
    var recipients:[Recipient] = []
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData() {
        let context = persistentContainer.viewContext
        let messagesRequest: NSFetchRequest<Message> = Message.fetchRequest()
        let recipientRequest: NSFetchRequest<Recipient> = Recipient.fetchRequest()
        
        do {
            messages = try context.fetch(messagesRequest)
            recipients = try context.fetch(recipientRequest)
            
            messages.sort(by: { (message1, message2) -> Bool in
                let date1 = message1.createdAt! as Date
                let date2 = message2.createdAt! as Date
                return date1 < date2
            })
            
            recipients.sort { $0.name! < $1.name! }
            
        } catch let error {
            print("Error fetching data: \(error)")
            messages = []
        }
        
        if messages.count == 0 {
            generateTestData()
        }
    }
    
    func generateTestData() {
        let context = persistentContainer.viewContext
        
        let messageOne: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageOne.content = "Message 1"
        messageOne.createdAt = NSDate()
        
        let messageTwo: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageTwo.content = "Message 2"
        messageTwo.createdAt = NSDate()
        
        let messageThree: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageThree.content = "Message 3"
        messageThree.createdAt = NSDate()
        
        saveContext()
        fetchData()
    }
    
}
