//
//  AddIngredientViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/26/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import CoreData

class AddIngredientViewController: UIViewController {
    
    private var allIngredients:[String] = []

    @IBOutlet weak var currentList: UILabel!
    var stringToPass:String = ""
    @IBOutlet weak var ingredientName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addIngredient(_ sender: Any) {
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*let destinationVC = segue.destination as! AddDishViewController
        destinationVC.receiveString = stringToPass*/
        let destinationVC = segue.destination as! AddDishViewController
        destinationVC.receiveArray = allIngredients
    }
    
    @IBAction func addMore(_ sender: UIButton) {
        
        if ingredientName.text == ""{
            //alert
            let alert = UIAlertController(title: "New Ingredient",
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
            
            allIngredients.append(ingredientName.text!)
            currentList.text = "\(allIngredients)"
            
        }
        
        
    }
    
}
