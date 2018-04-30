//
//  AddDishViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/4/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import CoreData

class AddDishViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var dishName: UITextField!
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    let orderedImages: [String] = ["Chicken.png", "Beef.png", "Pork.png", "Vegetarian.png", "Turkey.png", "Fish.png"]
    
    var pageIndex:Int = 0
    var strPhotoName:String!
    
    var dishes = [NSManagedObject]()
    var receiveString: String?
    private var ingredients: [String] = []
    var receiveArray: [String]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
     
        /*if receiveString != nil{
            
            ingredients += [receiveString!]
            print(ingredients)
            
        }
        else{
            print("no")
        }*/
        
        if receiveArray?.count != nil{
            for i in receiveArray!{
                ingredients.append(i)
            }
        }
        
    }
    

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredients.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AddIngredientTableViewCell"
        //displays info in table view cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? AddIngredientTableViewCell else {
            fatalError("The dequeued cell is not an instance of PeopleTableViewCell")
        }
        
        //set person according to row number
        let ingredient = ingredients[indexPath.row]
        
        //replace cell with person name
        cell.ingredientLabel.text = ingredient
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDish(_ sender: UIButton) {
        if dishName.text == ""{
            print("boo")
            //alert
            let alert = UIAlertController(title: "New Dish",
                                          message: "You must enter a value for all fields.",
                                          preferredStyle: .alert)
            present(alert,
                    animated: true,
                    completion: nil)
            let okAction = UIAlertAction(title: "OK",
                                         style: .default) { (action: UIAlertAction!) -> Void in
            }
            alert.addAction(okAction)
        }
        else{
            
            self.saveDish(dishName.text!)
            
        }
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        print("yo")
        pageIndex = pageIndex + 1
        if pageIndex >= orderedImages.count {
            pageIndex = 0
        }
        print(pageIndex)
        imageView.image = UIImage(named:orderedImages[pageIndex])
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = ingredientTable.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            
            //segue from this controller to person view controller, sending in person according to row selection
            let destinationVC = segue.destination as! DishInfoViewController
            destinationVC.dish = self.ingredients[selectedRow] as! Dish
        }
    }
    
    

    func saveDish(_ dishName:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Dish", in: managedContext)
        let dish = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        dish.setValue(dishName, forKey: "name")
        dish.setValue(receiveArray, forKey: "ingredients")
        

        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        dishes.append(dish)
    }
}
