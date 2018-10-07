//
//  VSInputModel.swift
//  TempR&D
//
//  Created by IPVision on 3/3/18.
//  Copyright © 2018 ipvision. All rights reserved.
//

import UIKit

enum VSInputType {
    case dose
    case weight
    case infusateVolume
    case dissolvedDrug
    case infusionRate
}

enum VSUnitType {
    case kg
    case ml
    case mg
    case mcg
    case mcg_kg_min
    case mcg_min
    case min
    case ml_hr
    case unit_min
    case unit
}

class VSInputModel: NSObject {

     var title : String?
     var message : String?
     var placeholderText : String?
    
    var type : VSInputType?
   
    var unit : VSUnitType?
    var value : Float?
    var isEnable : Bool?


    override init () {
       //super.init()
    }
    

    
    convenience init(withType type:VSInputType, withUnit unitType:VSUnitType, withEnableState state:Bool) {

       self.init()
       self.type = type
       self.unit = unitType
       self.isEnable = state
       self.initializeData()

    }
    
    func initializeData() {
        
        switch self.type {
        case .dose?:
            self.title = "Dose"
            self.value = 0.0
            self.message = "Please enter desired dose"
            self.placeholderText = "dose"
            
        case .weight?:
            self.title = "Weight"
            self.value = 0.0
            self.message = "Please enter weight"
            self.placeholderText = "weight"
            
        case .infusateVolume?:
            self.title = "Infusate Volume"
            self.value = 0.0
            self.message = "Please enter infusate volume"
            self.placeholderText = "infusate volume"
            
        case .dissolvedDrug?:
            self.title = "Dissolved Drug"
            self.value = 0.0
            self.message = "Please enter dissolved drug"
            self.placeholderText = "dissolved drug"
            
        case .infusionRate?:
            self.title = "Infusion Rate"
            self.value = 0.0
            self.message = "Please enter infusion rate"
            self.placeholderText = "infusion rate"
            
        default:
            
            self.title = "Dissolved Drug"
            self.value = 0.0
            
        }
        
    }
    
    
    
    
    
}
