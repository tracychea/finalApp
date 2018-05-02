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
        
        
        //ALL OF THIS IS TABLE VIEW V
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var postRef = Database.database().reference().child("users/profile/\(uid)/Dish List/\(dish!)/ingredients List")
        print(dish!)
        var refHandle = postRef.observe(.value, with: { (snapshot) in
            if let postDict = snapshot.value as? [String : AnyObject]{
                print(postDict)
                for i in postDict.keys{
                    self.ingredientsArray.append(String(describing: i))
                }
                
                self.ingredientTable.reloadData()
            } else {
                print("DOesnt work")
            }
        })
        self.navigationController?.isNavigationBarHidden = false
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        //ALL OF THIS IS TABLE VIEW ^
        
        //ALL OF THIS IS IMAGE VIEW
        func downloadPhoto () {
            var dbRef3 = Database.database().reference().child("user/profile/\(uid)/Dish List/\(dish!)/photo")
                .observe(.value,
                         with: {
                            snapshot in
                            // Swift typing is tough.  Array hack is unholy
                            // Better is the code in downloadAllPhotos
                            let outerDict = snapshot.value as? [String:AnyObject]
                            let photo = PhotoObject(Array(outerDict!)[0].value as! Dictionary<String, Any>)
                            print(photo)
                            self.dishImage.image = photo.image
                })
        }
        
        
        
        /*print(dish?.ingredients)
        var ingredientArray:[String] = dish?.ingredients as! [String]
        for i in ingredientArray{
            ingredientsArray.append(i)
        }*/

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
