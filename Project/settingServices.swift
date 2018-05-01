//
//  settingServices.swift
//  Project
//
//  Created by David Do on 4/27/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import Foundation
import UIKit

class settingService{
    var receivedString: String?
    class var sharedService : settingService {
        struct Singleton {
            static let instance = settingService()
        }
        return Singleton.instance
    }
    
    init() { }
    
    var backgroundColor : UIColor {
        get {
            var data: NSData? = UserDefaults.standard.object(forKey: "backgroundColor") as? NSData
            var returnValue: UIColor?
            if data != nil {
                returnValue = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? UIColor
                print("Something")
            } else {
                if settingViewController.GlobalVariable.myString == "Red"{
                    returnValue = UIColor.red
                }
                if settingViewController.GlobalVariable.myString == "Blue"{
                    returnValue = UIColor.blue
                }else {
                    returnValue = UIColor.gray
                }
                
                
            }
            return returnValue!
        }
        set (newValue) {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(data, forKey: "backgroundColor")
            UserDefaults.standard.synchronize()
        }
    }
    func backgroundColorChanged(color : UIColor) {
        settingService.sharedService.backgroundColor = color;
    }
}
