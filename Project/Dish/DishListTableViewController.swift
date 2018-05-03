//
//  DishListTableViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/4/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class DishListTableViewController: UITableViewController {
    
    
    
    private var dishes: [String] = []
    var dishes2: [String] = []
    
    var databaseHandle: DatabaseHandle?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = settingService.sharedService.backgroundColor;
        UILabel.appearance().font = settingService.sharedService.fontStyle;
        UITextView.appearance().font = settingService.sharedService.fontStyle;
        UITextField.appearance().font = settingService.sharedService.fontStyle;
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var postRef = Database.database().reference().child("users/profile/\(uid)/Dish List")
        var refHandle = postRef.observe(.value, with: { (snapshot) in
            if let postDict = snapshot.value as? [String : AnyObject]{
                for i in postDict.keys{
                    if self.dishes.contains(i){
                        continue
                    }else{
                    self.dishes.append(i)
                    }
                }
               
                self.tableView.reloadData()
            } else {
                print("Doesnt work")
            }
        })
        tableView.allowsMultipleSelectionDuringEditing = true
    
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let removeItem = self.dishes[indexPath.row]
        Database.database().reference().child("users/profile/\(uid)/Dish List").child(removeItem).removeValue()
        self.dishes.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       /* let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Dish")
        var fetchedResults:[NSManagedObject]? = nil
        
        // Try and get data
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Set data to local variable
        if let results = fetchedResults {
            dishes = results as! [User]
        } else {
            print("Could not fetch")
        } */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dishes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //use tableviewcell to view cells
        let cellIdentifier = "DishNameIdentifier"
        //displays info in table view cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DishListTableViewCell else {
            fatalError("The dequeued cell is not an instance of PeopleTableViewCell")
        }
        
        //set person according to row number
        let dish = self.dishes[indexPath.row]
        
        //replace cell with person name
        cell.dishName.text = dish
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            
            //segue from this controller to person view controller, sending in person according to row selection
            let destinationVC = segue.destination as! DishInfoViewController
            destinationVC.dish = self.dishes[selectedRow]
        }
    
    }


}
