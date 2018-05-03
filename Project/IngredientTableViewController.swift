//
//  IngredientTableViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/11/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import CoreData
import Firebase
class IngredientTableViewController: UITableViewController {
    
   // private var Ingredientlist: [ingredientList] = []
    var ingredient = [String]()
    var appendList = [String]()
    
    //weak var checkImage: UIImageView! //{box.png}
    
    
    
    
    var itemToDelete = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = settingService.sharedService.backgroundColor;
        //var image : UIImage = UIImage(named:"box")!
        //checkImage = UIImageView(image: image)
        if appendList != nil {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let databaseRef = Database.database().reference().child("users/profile/\(uid)/Grocery List")
            for i in appendList{
                
                databaseRef.child(i).setValue("")
            }
            
        }
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var postRef = Database.database().reference().child("users/profile/\(uid)/Grocery List")
        var refHandle = postRef.observe(.value, with: { (snapshot) in
            if let postDict = snapshot.value as? [String : AnyObject]{
                for i in postDict.keys{
                    self.ingredient.append(i)
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("DOesnt work")
               /*
                for i in 0...1{
                    Database.database().reference().child("users/profile/\(uid)/Grocery List").setValue("Grocery List")
                    continue
                }
                */
                
                
            }
        self.tableView.reloadData()
        })
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let item = self.ingredient[indexPath.row]
            
        
        Database.database().reference().child("users/profile/\(uid)/Grocery List").child(item).removeValue()
        self.ingredient.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Ingredient")
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
        /*if let results = fetchedResults {
            ingredient = results
        } else {
            print("Could not fetch")
        }*/
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.ingredient.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "IngredientTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?
            IngredientTableViewCell else {
                fatalError("The dequeued cell is not an instance of TableViewCell")
        }
        
        // Configure the cell...
        let ingredientlists = ingredient[indexPath.row]
        
        cell.ingredientList.text = ingredientlists
        
        //itemToDelete = (ingredientlists.value(forKey: "ingredient") as? String)!
        return cell
        
    }
    
    @IBAction func deleteIngredient (_ingredientList:Any) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var postRef = Database.database().reference().child("users/profile/\(uid)")
        
        var refHandle = postRef.observe(.value, with: { (snapshot) in
            if var postDict = snapshot.value as? [String : AnyObject]{
                print("pls")
                var childArray = [String]()
                
                
                for i in postDict.keys{
                    print(i)
                    if i == "Grocery List"{
                        postRef.child("Grocery List").removeValue()
                        
                    }
 
                }
                //postRef.child("Grocery List").setValue(["abc":""])
                
                self.tableView.reloadData()
            }else{
                print("no")
            }
            
            
        })
        


    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    

    

    
    
    
    
    
}

