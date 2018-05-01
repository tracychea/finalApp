//
//  settingViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/26/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit

class settingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    struct GlobalVariable{
        static var myString: String = ""
    }
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropMenu: UIPickerView!
    @IBOutlet weak var fontTester: UILabel!
    
    var colorList = ["Red", "Blue","Gray"]
    public var font: String = "HelveticaNeue-UltraLight"
    
    var sentString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = settingService.sharedService.backgroundColor;
        
    


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return colorList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return colorList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.textBox.text = self.colorList[row]
        self.dropMenu.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.textBox {
            self.dropMenu.isHidden = false
            //if you dont want the users to se the keyboard type:
            
            textField.endEditing(true)
        }
        
    }

    @IBAction func saveSetting(_ sender: Any) {
        if textBox.text == "Red"{
          //fontTester.font = UIFont(name: font, size: 21)
            GlobalVariable.myString = "Red"
            self.view.backgroundColor = settingService.sharedService.backgroundColor;

        }
        if textBox.text == "Blue"{
            GlobalVariable.myString = "Blue"
            self.view.backgroundColor = settingService.sharedService.backgroundColor;
        }
        if textBox.text == "Gray"{
            GlobalVariable.myString = "Gray"
            self.view.backgroundColor = settingService.sharedService.backgroundColor;
        }
    }
    
}


