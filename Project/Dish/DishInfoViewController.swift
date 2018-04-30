//
//  DishInfoViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/4/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit


class DishInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dish: Dish?
    @IBOutlet weak var dishImage: UIImageView!
    private var ingredientsArray: [String] = []
  
    @IBOutlet weak var ingredientTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        self.title = dish?.name
        print(dish?.ingredients)
        var ingredientArray:[String] = dish?.ingredients as! [String]
        for i in ingredientArray{
            ingredientsArray.append(i)
        }

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
