//
//  DishInfoViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/4/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import Firebase


class DishInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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

    var dish: String?
    
    @IBOutlet weak var dishImage: UIImageView!
    private var ingredientsArray: [String] = []
  
    @IBOutlet weak var ingredientTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = settingService.sharedService.backgroundColor;
        UILabel.appearance().font = settingService.sharedService.fontStyle;
        UITextView.appearance().font = settingService.sharedService.fontStyle;
        UITextField.appearance().font = settingService.sharedService.fontStyle;

        //ALL OF THIS IS TABLE VIEW V
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var postRef = Database.database().reference().child("users/profile/\(uid)/Dish List/\(dish!)/ingredients List")
        
        var refHandle = postRef.observe(.value, with: { (snapshot) in
            if let postDict = snapshot.value as? [String : AnyObject]{
                
                for i in postDict.keys{
                    self.ingredientsArray.append(String(describing: i))
                }
                
                self.ingredientTable.reloadData()
            }
        })
        self.title = dish!
        self.navigationController?.isNavigationBarHidden = false
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        //ALL OF THIS IS TABLE VIEW ^
        
        //ALL OF THIS IS IMAGE VIEW
        func downloadPhoto () {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            var postRef = Database.database().reference().child("users/profile/\(uid)/Dish List/\(dish!)/photo")
            var refHandle = postRef.observe(.value, with: { (snapshot) in
                if let preDict = snapshot.value as? [String : AnyObject]{
                    let encodedData = preDict["encodedBytes"] as! String
                    
                    let data = Data(base64Encoded: encodedData)
                    let photo = UIImage(data: data!)
                    
                    self.dishImage.image = photo
                    self.ingredientTable.reloadData()
                }
            })        }
        
        downloadPhoto()
        ingredientTable.allowsMultipleSelectionDuringEditing = true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.ingredientsArray[indexPath.row]
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var postRef = Database.database().reference().child("users/profile/\(uid)/Dish List/\(dish!)/ingredients List")
        postRef.child(item).removeValue()
        self.ingredientsArray.remove(at: indexPath.row)
        self.ingredientTable.deleteRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func addDishToGrocery(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var postRef = Database.database().reference().child("users/profile/\(uid)/Grocery List")
        for i in self.ingredientsArray{
            
            postRef.child(i).setValue("")
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ShowIngredientTableViewCell"
        //displays info in table view cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? ShowIngredientTableViewCell else {
            fatalError("The dequeued cell is not an instance of PeopleTableViewCell")
        }
        
        //set person according to row number
        let ingredient = ingredientsArray[indexPath.row]
        
        //replace cell with person name
        cell.ingredientLabel.text = ingredient
        
        return cell
    }
    
    
    /*@IBAction func addToGrocery(_ sender: Any) {
        let destinationVC = AddGroceryViewController()
        destinationVC.appendList = self.ingredientsArray
        
        
        /*let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "AddGroceryViewController")
        destinationController.appendList = self.ingredientsArray*/
        print("pressed")
    }*/
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        //segue from this controller to person view controller, sending in person according to row selection
        let destinationVC = segue.destination as! IngredientTableViewController
        destinationVC.appendList = self.ingredientsArray
 
    }*/
    

}
