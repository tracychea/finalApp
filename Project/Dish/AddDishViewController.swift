//
//  AddDishViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/4/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class AddDishViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    struct PhotoObject {
        var image : UIImage!
        init(_ dict : Dictionary<String, Any>) {
            image = UIImage(data:
                Data(base64Encoded: dict["encodedBytes"] as! String)!)
        }
        init(image : UIImage!) {
            self.image = image
        }
        func toAnyObject() -> Any {
            return ["encodedBytes" : UIImageJPEGRepresentation(image, 1.0)?.base64EncodedString() as Any
                ] as Any
        }
    }

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
    /*func fetchUser() {
        Database.database().reference().child("user").observe(<#T##eventType: DataEventType##DataEventType#>, andPreviousSiblingKeyWith: <#T##(DataSnapshot, String?) -> Void#>, withCancel: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>)
        //Database.database().reference().child("user/profile/\(uid)").observeEventType(.child)
        
    }*/
    

 
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
    func uploadPhoto () {
        // NB Image should be a file, it is too big for DB
        let photo =
            PhotoObject(image: UIImage(named:orderedImages[pageIndex]))
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)"+"/Photo")
        databaseRef.child(dishName.text!).setValue(photo.toAnyObject())
    }
    
    func toAnyObject(image: UIImage) -> Any {
        return ["encodedBytes" : UIImageJPEGRepresentation(image, 1.0)?.base64EncodedString() as Any
            ] as Any
    }
    

    func saveDish(_ sender: Any){

        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)"+"/Dish List")
    

        let dishIngredients = [
            "ingredients List" : ingredients
        ]
        databaseRef.child(dishName.text!).setValue(dishIngredients)
        
        //trying to save to database
        uploadPhoto()
       
        
        
       //this will only add to storage and not data base
       /* let metaData = StorageMetadata()
        let storageRef = Storage.storage().reference().child("users/profile/\(uid)"+"/Dish List")
        guard let photo = UIImageJPEGRepresentation(UIImage(named:orderedImages[pageIndex])!, 0.75) else {return}
        metaData.contentType = "image/jpg"
        
        storageRef.putData(photo, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                print("Success")
            } else {
                print("DIDNT WORK BITCHHH")
            }
            
        } */
      
        
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        dishes.append(dish)*/
    }
}
