//
//  IngredientTableViewCell.swift
//  Project
//
//  Created by Tracy Chea on 4/11/18.
//  Copyright © 2018 Tracy Chea. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientList: UILabel!
    
   
    
    @IBOutlet weak var unCheck: UIButton!
    @IBOutlet weak var check: UIButton!
    
    func setButtons()
    {
        unCheck.isHidden = true
    }
    
    @IBAction func checkButton(_ sender: Any) {
        check.isHidden = false
        unCheck.isHidden = true
    }
   
    @IBAction func uncheckButton(_ sender: Any) {
        check.isHidden = true
        unCheck.isHidden = false    }
    

    // @IBAction func button(sender: UIButton) {
    
    // button.setImage(UIImage(named: "myImage.png")!, forState: .Normal)
    // button.setImage(UIImage(named: "checkBox.png")!, for: .selected)
    //button.setImage(UIImage(named: "checkBox"), for: .selected)
    // if checked == false {
    //      button.setImage(UIImage(named:"box"), for: .normal)
    //       checked = true
    //  } else {
    //        button.setImage(UIImage(named:"checkBox"), for: .normal)
    //        checked = false
    //    }
    //}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

