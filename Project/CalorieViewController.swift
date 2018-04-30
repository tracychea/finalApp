//
//  CalorieViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/11/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit

class CalorieViewController: UIViewController {
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var genderOption: UISegmentedControl!
    @IBOutlet weak var caloricSuggestion: UILabel!
    @IBOutlet weak var age: UITextField!
    var gender = "Male"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func genderSelection(_ sender: Any) {
        switch self.genderOption.selectedSegmentIndex
        {
            case 0:
                self.gender = "Male"
            case 1:
                self.gender = "Female"
            default:
                break
        }
    }
    
    @IBAction func calculate(_ sender: Any) {
        let totalCalories = 0
        if height.text == "" || weight.text == "" || age.text == ""
        {
            //alert
            let alert = UIAlertController(title: "Calorie Calculator",
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
            var totalCalories:Double = 0.00
            if self.gender == "Male"
            {
                
               //calories for male
               // self.height = Double(height.text!) * 2.54
                var heightValue = Double((height.text! as NSString).doubleValue) * 2.54
                
                var weightValue = Double((weight.text! as NSString).doubleValue) * 0.453592
                //height = Double(height.text!) * 2.54
                //weightValue = Double(weight.text) * 0.453592
                weightValue = weightValue * 13.8
                totalCalories = 166.5 + (weightValue)
                totalCalories = totalCalories + 5 * heightValue
            }
            
            else
            {
                //calories for female
                var heightValue = Double((height.text! as NSString).doubleValue) * 2.54
                
                var weightValue = Double((weight.text! as NSString).doubleValue) * 0.453592
                
                totalCalories = 655.1 + (9.6 * (weightValue * 00.453592)) + (1.9 * (heightValue * 2.54))
            }
            caloricSuggestion.text = String(totalCalories)
        }

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
