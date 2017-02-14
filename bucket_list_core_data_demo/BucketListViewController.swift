//
//  BucketListViewController.swift
//  bucket_list_core_data_demo
//
//  Created by Andy Feng on 2/14/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddMissionDelegate {

    // Global Variables ::::::::::::::::::::::::::::::::::::::
    var missionArray = [Mission]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // Actions :::::::::::::::::::::::::::::::::::::::::::::::
    @IBAction func handleAddButtonPressed(_ sender: UIBarButtonItem) {
        
        // Transition to the AddVC
        DispatchQueue.main.async {
            
            // Instantiate the destination view controller
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addVC") as! AddViewController
            
            // Set properties of vc
            vc.addMissionDelegate = self
            
            // Transition
            self.present(vc, animated: true, completion: nil)
 
        }
    }
    

    // UI Lifecycle ::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAllMissions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // Table View Methods :::::::::::::::::::::::::::::::::::
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.missionArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = self.missionArray[indexPath.row].content
        return cell
    }
    
    // Edit the mission ***********************************************************
    // ****************************************************************************
    // ****************************************************************************
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Instantiate the destination view controller
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addVC") as! AddViewController
        
        // Set properties of vc
        vc.addMissionDelegate = self
        vc.missionToEdit = self.missionArray[indexPath.row]
        
        // Transition
        self.present(vc, animated: true, completion: nil)
        
    }
    
    // Swipe to delete ************************************************************
    // ****************************************************************************
    // ****************************************************************************
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // Delete the object from core data
        self.context.delete(self.missionArray[indexPath.row])
        // Save the changes
        if self.context.hasChanges {
            do {
                try self.context.save()
                print("successfully deleted a mission from core data")
                self.fetchAllMissions()
            } catch {
                print("\(error)")
            }
        }
    }
    
    
    
    
    // Core Data Methods :::::::::::::::::::::::::::::::::::
    func fetchAllMissions() {
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mission")
        do {
            self.missionArray = try context.fetch(userRequest) as! [Mission]
            print("got all the missions from core data")
            self.tableView.reloadData()
        } catch {
            print("\(error)")
        }
    }
    
    
    // Protocol Methods ::::::::::::::::::::::::::::::::::::
    func doneAddingNewMission() {
        self.fetchAllMissions()
    }

}











