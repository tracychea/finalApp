//
//  IngredientTableViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/11/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import CoreData
class IngredientTableViewController: UITableViewController {
    
   // private var Ingredientlist: [ingredientList] = []
    var ingredient = [NSManagedObject]()
    
    //weak var checkImage: UIImageView! //{box.png}
    
    
    
    
    var itemToDelete = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //var image : UIImage = UIImage(named:"box")!
        //checkImage = UIImageView(image: image)
        
        
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
        if let results = fetchedResults {
            ingredient = results
        } else {
            print("Could not fetch")
        }
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
        
        cell.ingredientList.text = ingredientlists.value(forKey: "ingredient") as? String
        //itemToDelete = (ingredientlists.value(forKey: "ingredient") as? String)!
        return cell
        
    }
    
    @IBAction func deleteIngredient (_ingredientList:Any) {
        self.deleteFromCoreData()
        DispatchQueue.main.async {
            self.tableView!.reloadData()
            //self.tableView.reloadRowsAtIndexPaths( withRowAnimation: UITableViewRowAnimation.None)
            //      self.IngredientTableViewController.reloadData()
            // let rowNumber: Int = 0
            //let sectionNumber: Int = 0
            
            //let indexPath = IndexPath(item: rowNumber, section: sectionNumber)
            
            //self.tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    func deleteFromCoreData() -> Void {
        //  let indexPath = tableView.indexPathForSelectedRow
        let moc = getContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        //  fetchRequest.predicate = NSPredicate(format: "movieTitle == %@")
        //let fetchRequest.predicate = NSPredicate(forKey: "ingredient", itemToDelete)
        
        let result = try? moc.fetch(fetchRequest)
        let resultData = result as! [Ingredient]
        
        for object in resultData {
            moc.delete(object)
            //  moc.delete(fetchRequest[indexPath.row])
        }
        
        do {
            try moc.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    
    
    /*    let indexPath = tableView.indexPathForSelectedRow
     // let selectedRow =  indexPath?.row
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as?
     IngredientTableViewCell else {
     fatalError("The dequeued cell is not an instance of TableViewCell")
     
     }
     
     let grocery = cell.ingredientList.text
     //  let grocery = ingredientList.self
     self.SaveIngredient(grocery.text)
     */
    
    
    //   }
    /*   func SaveIngredient (_grocery:AnyObject) {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let managedContext = appDelegate.persistentContainer.viewContext
     let entity = NSEntityDescription.entity(forEntityName: "Ingredients", in: managedContext)
     let ingredient = NSManagedObject(entity: entity!, insertInto: managedContext)
     
     
     //print(grocery)
     
     ingredient.setValue(grocery, forKey: "item")
     
     do {
     try managedContext.save()
     } catch {
     // what to do if an error occurs?
     let nserror = error as NSError
     NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
     abort()
     }
     
     ingredients.append(ingredient)
     }*/
    // if let indexPath = tableView.indexPathForSelectedRow {
    //   let selectedRow =  indexPath.row
    //   let destinationVC = segue.destination as! ListTableViewController
    //   destinationVC.ingredients = self.Ingredientlist[selectedRow]
    
    
    
    //            GroceryList.append(GroceryList(ingredient:self.Ingredientlist[selectedRow]))
    //let cellIdentifier = "IngredientTableViewCell"
    //   let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for cellForRowAt indexPath)
    // let Ingredient = Ingredientlist.ingredient.text!
    // self.saveIngredient(Ingredient)
    
    
    //  func prepare(for segue: UIStoryboardSegue,  sender: Any?) {
    //    if let indexPath = tableView.indexPathForSelectedRow {
    //         let selectedRow =  indexPath.row
    //        let destinationVC = segue.destination as! ListTableViewController
    //        destinationVC.ingredient = self.Ingredientlist[selectedRow]
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    
    
    
    
    
    
    
}

