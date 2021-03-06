//
//  LoginViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/12/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var icon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = settingService.sharedService.backgroundColor;
        UILabel.appearance().font = settingService.sharedService.fontStyle;
        UITextView.appearance().font = settingService.sharedService.fontStyle;
        UITextField.appearance().font = settingService.sharedService.fontStyle;
        icon.image = UIImage(named: "Asset 1.png")
        //self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginUserButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, error in
            if error == nil && user != nil {
                //take to tableviewcontroller
                let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController")
                self.present(destinationController!, animated: true, completion: nil)
            } else {
                let alert2 = UIAlertController(title: "Error", message: "Incorrect email or incorrect password", preferredStyle: .alert)
                self.present(alert2, animated: true, completion: nil)
                let okButton = UIAlertAction(title: "OK", style: .default){(action: UIAlertAction)-> Void in
                }
                alert2.addAction(okButton)
            }
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
