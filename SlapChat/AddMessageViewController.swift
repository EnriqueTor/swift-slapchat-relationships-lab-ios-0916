//
//  ViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {
    
    @IBOutlet weak var addMessageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func saveMessageButtonTapped(_ sender: AnyObject) {
        let store = DataStore.sharedInstance
        let context = store.persistentContainer.viewContext
        let newMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        newMessage.content = addMessageTextField.text
        newMessage.createdAt = NSDate()
        store.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

class AddRecipientViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let store = DataStore.sharedInstance
        let context = store.persistentContainer.viewContext
        let newRecipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: context) as! Recipient
        newRecipient.name = textField.text
        newRecipient.email = emailField.text
        newRecipient.phoneNumber = phoneField.text
        newRecipient.twitterHandle = twitterField.text
        store.saveContext()
        store.recipients.append(newRecipient)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

