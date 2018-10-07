//
//  VSWeightViewCell.swift
//  TempR&D
//
//  Created by IPVision on 3/3/18.
//  Copyright © 2018 ipvision. All rights reserved.
//

import UIKit

class VSWeightViewCell: UITableViewCell {

     @IBOutlet weak var textField : UITextField!
     @IBOutlet weak var lblTitle : UILabel!
     @IBOutlet weak var lblUnit : UILabel!
     @IBOutlet weak var switchWeight : UISwitch!
    
      @IBOutlet weak var containerView: UIView!
    
     var selectionDelegate : VSInputViewCellDelegate?
     var item : VSInputModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
           self.containerView.shadow()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setInformationOnView(withItem item: VSInputModel){
        
         self.item = item
        switchWeight.setOn((self.item?.isEnable)!, animated: false)
        
        
        self.lblTitle.text = item.title
        
        if let isEnable = item.type, isEnable == .weight {
            self.switchWeight.isHidden = false
        } else {
             self.switchWeight.isHidden = true
        }
        
        switch item.unit {
        case .mcg?:
           self.lblUnit.text = "mcg"
            
        case .mg?:
           self.lblUnit.text = "mg"
            
        case .min?:
           self.lblUnit.text = "min"
            
        case .ml?:
            self.lblUnit.text = "ml"
        case .kg?:
            self.lblUnit.text = "kg"
            
        default:
            
            self.lblUnit.text = "mm"
            
        }
        
        textField.text =  String(format: "%.2f", item.value!)
        textField.placeholder = item.placeholderText
        
        
    }
    
    @IBAction func onTapCustomAlertButton(_ sender: Any) {
        
        if let checkWeightEnable = self.item?.isEnable,  checkWeightEnable == true {
            
            self.selectionDelegate?.didSelectedInputItem(withInformation:self.item)
        }
        
        
    }
    
    @IBAction func switchStateDidChange(_ sender:UISwitch!)
    {
        if (sender.isOn == true){
            
            item?.isEnable = true
        self.selectionDelegate?.didUpdateEnableStatusOfSelectedInputItem(withInformation:self.item)
            print("UISwitch state is now ON")
        }
        else{
             item?.isEnable = false
        self.selectionDelegate?.didUpdateEnableStatusOfSelectedInputItem(withInformation:self.item)
            print("UISwitch state is now Off")
        }
    }
    
}




