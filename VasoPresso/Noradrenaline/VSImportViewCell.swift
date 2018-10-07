//
//  VSTaskViewCell.swift
//  TempR&D
//
//  Created by IPVision on 3/3/18.
//  Copyright © 2018 ipvision. All rights reserved.
//

import UIKit



class VSImportViewCell: UITableViewCell {

    @IBOutlet weak var textField : UITextField!
     @IBOutlet weak var lblTitle : UILabel!
     @IBOutlet weak var lblUnit : UILabel!
    
      @IBOutlet weak var containerView: UIView!
    
    var item : VSInputModel?
    
    var selectionDelegate : VSInputViewCellDelegate?
   
    
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
        
        self.lblTitle.text = item.title
        switch item.unit {
        case .mcg?:
           self.lblUnit.text = "mcg"
        case .mcg_kg_min?:
            self.lblUnit.text = "mcg/kg/min"
        case .mcg_min?:
            self.lblUnit.text = "mcg/min"
        case .mg?:
           self.lblUnit.text = "mg"
            
        case .min?:
           self.lblUnit.text = "min"
            
        case .ml?:
            self.lblUnit.text = "ml"
        case .kg?:
            self.lblUnit.text = "kg"
        case .ml_hr?:
            self.lblUnit.text = "ml/hr"
        case .unit_min?:
            self.lblUnit.text = "Unit/min"
        case .unit?:
            self.lblUnit.text = "Unit"
        default:
            
            self.lblUnit.text = "mm"
            
        }

        textField.text =  String(format: "%.2f", item.value!)
        textField.placeholder = item.placeholderText
        
        
    }
    
    
    @IBAction func onTapCustomAlertButton(_ sender: Any) {
        
        self.selectionDelegate?.didSelectedInputItem(withInformation:self.item)
    }
    
}





