//
//  SignUpViewController.swift
//  Project
//
//  Created by Tracy Chea on 4/12/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var cPasswordText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
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

    @IBAction func signUpButton(_ sender: Any) {
        if(firstNameText.text?.isEmpty)! ||
            (firstNameText.text == "First Name") ||
            (lastNameText.text?.isEmpty)! ||
            (lastNameText.text == "Last Name") ||
            (usernameText.text?.isEmpty)! ||
            (usernameText.text == "Username") ||
            (passwordText.text?.isEmpty)! ||
            (passwordText.text == "Password") ||
            (cPasswordText.text?.isEmpty)! ||
            (cPasswordText.text == "Confirm Password")  ||
            (emailTextField.text?.isEmpty)! ||
            (emailTextField.text == "Email")
        {
            //Display Alert Message
            let alert = UIAlertController(title: "ERROR", message: "Not all required fields are filled properly", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "OK", style: .default){(action: UIAlertAction)-> Void in
            }
            alert.addAction(okButton)
            
        } else if (passwordText.text != cPasswordText.text){
            let alert2 = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            present(alert2, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "OK", style: .default){(action: UIAlertAction)-> Void in
            }
            alert2.addAction(okButton)
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordText.text!){ user, error  in
                if error == nil && user != nil {

                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.usernameText.text
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            //takes back to login screen when successfully signed up
                            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                            self.saveUserProfile(username: self.usernameText.text!) { success in
                                if success {
                                     self.present(destinationController!, animated: true, completion: nil)
                                    //self.dismiss(animated: true, completion: nil)
                                }
                            }
                        } else {
                           print("ERRRORRR: \(error!.localizedDescription)")
                        }
                    }
                } else {
                    print("Error: \(error!.localizedDescription)")
                }
            }
        }
    }
    func saveUserProfile(username: String, completion: @escaping((_ success: Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "Username": username
            ] as [String: Any]
        
        databaseRef.setValue(userObject) { error, ref in completion(error == nil)
        }
    }

    func saveUserInfo( firstName: String, lastName: String, username: String, password: String, cPassword: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let User = NSManagedObject(entity: entity!, insertInto:managedContext)
        // Set the attribute values
        User.setValue(firstName, forKey: "firstName")
        User.setValue(lastName, forKey: "lastName")
        User.setValue(username, forKey: "username")
        User.setValue(password, forKey: "password")
        User.setValue(cPassword, forKey: "cPassword")
        //User.setValue(cPassword, forkey: "cPassword")
        // ...
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
        
    }
