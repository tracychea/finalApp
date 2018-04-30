//
//  IngredientTableViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/11/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit

class IngredientTableViewController: UITableViewController {
    
    private var Ingredientlist: [ingredientList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataModel()
        
        
    }
    
    private func createDataModel() {
        
        Ingredientlist.append(ingredientList(ingredient: "carrots"))
        Ingredientlist.append(ingredientList(ingredient: "mushrooms"))
        Ingredientlist.append(ingredientList(ingredient: "cheese"))
        Ingredientlist.append(ingredientList(ingredient: "chicken breast"))
        Ingredientlist.append(ingredientList(ingredient: "steak"))
        Ingredientlist.append(ingredientList(ingredient: "pasta"))
        Ingredientlist.append(ingredientList(ingredient: "olive oil"))
        Ingredientlist.append(ingredientList(ingredient: "bell pepper"))
        
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
        return self.Ingredientlist.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "IngredientTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?
            IngredientTableViewCell else {
                fatalError("The dequeued cell is not an instance of TableViewCell")
        }
        
        // Configure the cell...
        let ingredientlists = Ingredientlist[indexPath.row]
        
        cell.ingredientList.text = ingredientlists.ingredient
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


