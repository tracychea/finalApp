//
//  settingViewController.swift
//  Project
//
//  Created by Tracy Chea on 5/1/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import Firebase

class settingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    
    //set global variables
    struct GlobalVariable{
        static var myString: String = ""
        static var textString: String = ""
        static var sizeString: Int = 0
    }
    var chosenColor: String?
    var chosenFont: String?
    
    //screen info
    @IBOutlet weak var dropMenu: UIPickerView!
    @IBOutlet weak var fontPicker: UIPickerView!
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var fontSize: UILabel!
    
    
    @IBAction func logout(_ sender: Any) {
        //try!Auth.auth().signOut()
        let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(destinationController!, animated: true, completion: nil)
        
    }
    
    //create options
    var colorList = ["Red", "Blue","Gray"]
    var fontList = ["Lao MN", "Avenir", "Damascus"]
    public var font: String = "HelveticaNeue-UltraLight"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = settingService.sharedService.backgroundColor;
        UILabel.appearance().font = settingService.sharedService.fontStyle;
        UITextView.appearance().font = settingService.sharedService.fontStyle;
        UITextField.appearance().font = settingService.sharedService.fontStyle;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        if (pickerView.tag == 1){
            return 1
        }else{
            return 1
        }
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView.tag == 1){
            return colorList.count
        }else{
            return fontList.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView.tag == 1){
            return colorList[row]
        }else{
            return fontList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView.tag == 1){
            self.chosenColor = self.colorList[row]
        }else{
            self.chosenFont = self.fontList[row]
        }
        
    }
    
    
    @IBAction func saveSetting(_ sender: Any) {
        
        //set color
        if chosenColor == "Red"{
            //fontTester.font = UIFont(name: font, size: 21)
            GlobalVariable.myString = "Red"
            self.view.backgroundColor = settingService.sharedService.backgroundColor;
            
        }
        if chosenColor == "Blue"{
            GlobalVariable.myString = "Blue"
            self.view.backgroundColor = settingService.sharedService.backgroundColor;
        }
        if chosenColor == "Gray"{
            GlobalVariable.myString = "Gray"
            self.view.backgroundColor = settingService.sharedService.backgroundColor;
        }
        
        //set font
        if chosenColor == "Lao MN"{
            GlobalVariable.textString = "Lao MN"
            GlobalVariable.sizeString = Int(CGFloat(fontSlider.value * 20.0))
            //var fontValue2 = UIFont(name: "LaoSangamMN", size: 15.0)
            //  settingService.sharedService.fontStyle = fontValue2!;
            self.fontSize.font = settingService.sharedService.fontStyle;
            self.fontLabel.font = settingService.sharedService.fontStyle;
            self.colorLabel.font = settingService.sharedService.fontStyle;
            UILabel.appearance().font = settingService.sharedService.fontStyle;
            UITextView.appearance().font = settingService.sharedService.fontStyle;
            UITextField.appearance().font = settingService.sharedService.fontStyle;
        }
        if chosenFont == "Avenir"{
            GlobalVariable.textString = "Avenir"
            GlobalVariable.sizeString = Int(CGFloat(fontSlider.value * 20.0))
            //   var fontValue1 = UIFont(name: "HelveticaNeue", size: 15.0)
            //    settingService.sharedService.fontStyle = fontValue1!;
            self.fontSize.font = settingService.sharedService.fontStyle;
            self.fontLabel.font = settingService.sharedService.fontStyle;
            self.colorLabel.font = settingService.sharedService.fontStyle;
            UILabel.appearance().font = settingService.sharedService.fontStyle;
            UITextView.appearance().font = settingService.sharedService.fontStyle;
            UITextField.appearance().font = settingService.sharedService.fontStyle;
        }
        if chosenFont == "Damascus"{
            GlobalVariable.textString = "Damascus"
            GlobalVariable.sizeString = Int(CGFloat(fontSlider.value * 20.0))

            //  var fontValue = UIFont(name: "DamascusLight", size: 15.0)
            //  settingService.sharedService.fontStyle = fontValue!;
            self.fontSize.font = settingService.sharedService.fontStyle;
            self.fontLabel.font = settingService.sharedService.fontStyle;
            self.colorLabel.font = settingService.sharedService.fontStyle;
            UILabel.appearance().font = settingService.sharedService.fontStyle;
            UITextView.appearance().font = settingService.sharedService.fontStyle;
            UITextField.appearance().font = settingService.sharedService.fontStyle;
        }
        colorLabel.text = chosenColor
        fontLabel.text = chosenFont
    }
    @IBAction func sliderSize(_ sender: AnyObject) {
        self.fontSize.font = UIFont.systemFont(ofSize: CGFloat(fontSlider.value * 20.0))
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
