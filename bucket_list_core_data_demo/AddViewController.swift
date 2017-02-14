//
//  AddViewController.swift
//  bucket_list_core_data_demo
//
//  Created by Andy Feng on 2/14/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData




class AddViewController: UIViewController {

    // Global Variables ::::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var addMissionDelegate: AddMissionDelegate?
    
    
    // Outlets and Actions :::::::::::::::::::::::::::::::::::
    @IBOutlet weak var inputField: UITextField!
    
    
    @IBAction func handleCancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSaveButtonPressed(_ sender: UIButton) {
        
        if let text = self.inputField.text {
            if text != "" {
                // Save to core data 
                let newMission = NSEntityDescription.insertNewObject(forEntityName: "Mission", into: context) as! Mission
                newMission.content = text
                
                if self.context.hasChanges {
                    do {
                        try self.context.save()
                        print("successfully saved a new mission to core data!")
                    } catch {
                        print("\(error)")
                    }
                }
                
                // In the bucket list view controller
                self.addMissionDelegate?.doneAddingNewMission()
                // - Grab all the data from core data again
                // - Reload the table view
                
                
                // Dismiss myself 
                self.dismiss(animated: true, completion: nil)

            }
        }
    }
    
    
    
    
    
    // UI Lifecycle ::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    

}
