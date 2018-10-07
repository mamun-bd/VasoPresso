//
//  VSMenuItem.swift
//  VasoPresso
//
//  Created by Scrupulous on 12/7/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit

enum VSMenuType {
    case adrenaline
    case noradrenaline
    case dopamine
    case dobutamine
    case vasopressin
}

class VSMenuItem: NSObject {

    var type : VSMenuType?
    var title : String?
    var icon : String?
    var options : NSMutableArray = []
    var doseOptions : NSMutableArray = []
    
    var doseItem : VSInputModel?
    var weightItem : VSInputModel?
    var infusateItem : VSInputModel?
    var dissolvedItem : VSInputModel?
    var infusionItem : VSInputModel?
    
   
    override init () {
      
    }
    
    convenience init(withType type:VSMenuType) {
        
        self.init()
        self.type = type
        self.initializeData()
        
    }
    
    func initializeData() {
        
        if let isVasopressin = self.type, isVasopressin == .vasopressin {
            
            self.doseItem = VSInputModel(withType: .dose, withUnit:.unit_min, withEnableState:true)
            options.add(self.doseItem!)
            
            self.dissolvedItem  = VSInputModel(withType: .dissolvedDrug, withUnit:.unit, withEnableState:true)
            options.add(self.dissolvedItem!)
            doseOptions.add(self.dissolvedItem!)
            
        } else {
            
            self.doseItem = VSInputModel(withType: .dose, withUnit:.mcg_kg_min, withEnableState:true)
            options.add(self.doseItem!)
            
            self.weightItem = VSInputModel(withType: .weight, withUnit:.kg, withEnableState:true)
            options.add(self.weightItem!)
            doseOptions.add(self.weightItem!)
            
            self.dissolvedItem  = VSInputModel(withType: .dissolvedDrug, withUnit:.mg, withEnableState:true)
            options.add(self.dissolvedItem!)
            doseOptions.add(self.dissolvedItem!)
            
        }

        
        
        self.infusateItem = VSInputModel(withType: .infusateVolume, withUnit:.ml, withEnableState:true)
        options.add(self.infusateItem!)
        doseOptions.add(self.infusateItem!)
        
        self.infusionItem = VSInputModel(withType: .infusionRate, withUnit:.ml_hr, withEnableState:true)
        doseOptions.add(self.infusionItem!)
        
        
        switch self.type {
        case .adrenaline?:
            self.title = "Adrenaline"
            self.icon = "adrenaline"

        case .noradrenaline?:
            self.title = "Noradrenaline"
            self.icon = "noradrenaline"
         
            
        case .dopamine?:
            self.title = "Dopamine"
            self.icon = "dopamine"

            
        case .dobutamine?:
            self.title = "Dobutamine"
            self.icon = "dobutamine"
      
        case .vasopressin?:
            
            self.title = "Vasopressin"
            self.icon = "vasopressin"
            
        default:
            
            self.title = "Noradrenaline"
            self.icon = "noradrenaline"
            
        }
        
    }
    
    func resetInformation() {
        
        for case let optionItem as VSInputModel  in self.options {
            
            optionItem.value = 0.0
            
        }
        
    }
    
    func getInfusionRate() -> Double {
        
        var infusionValue : Double = 0.0
        
        var doseValue : Double = 0.0
        var infusateVolumeValue : Double = 0.0
        var dissolvedDrugValue : Double = 0.0
        var weightValue : Double = 1.0
        var isWeightEnable : Bool? = false
        var literValue : Double = 1000.0
       
        for case let optionItem as VSInputModel  in self.options {
            
            switch optionItem.type {
            case .dose?:
                doseValue = Double(optionItem.value!)
            case .weight?:
                weightValue = Double(optionItem.value!)
                isWeightEnable = optionItem.isEnable!
            case .infusateVolume?:
                infusateVolumeValue = Double(optionItem.value!)
                
            case .dissolvedDrug?:
                dissolvedDrugValue = Double(optionItem.value!)
                
            case .infusionRate?:
               break
            case .none: break
                
            }
        }
        
        if let isVasopressin = self.type, isVasopressin == .vasopressin {
            literValue = 1.0
        }
        
        if let isEnable = isWeightEnable, isEnable == false {
            weightValue = 1.0
        }
        
        infusionValue = Double((doseValue * 60.0 * infusateVolumeValue * weightValue) / (dissolvedDrugValue * literValue))
        
        return infusionValue
        
    }
    
    func getDose() -> Double {
        
        var doseValue : Double = 0.0
        
        var infusionValue : Double!
        var infusateVolumeValue : Double!
        var dissolvedDrugValue : Double!
        var weightValue : Double = 1.0
        var isWeightEnable : Bool? = false
        
        for case let optionItem as VSInputModel  in self.doseOptions {
            
            switch optionItem.type {
            case .dose?: break
            case .weight?:
                weightValue = Double(optionItem.value!)
                isWeightEnable = optionItem.isEnable
            case .infusateVolume?:
                infusateVolumeValue = Double(optionItem.value!)
            case .dissolvedDrug?:
                dissolvedDrugValue = Double(optionItem.value!)
            case .infusionRate?:
                infusionValue = Double(optionItem.value!)
            case .none: break
            }
            
        }
        
        
        if let isEnable = isWeightEnable, isEnable == false {
            weightValue = 1.0
        }
        
        doseValue =  (infusionValue * dissolvedDrugValue * 1000) / (60 * infusateVolumeValue * weightValue)
        
        return doseValue
        
    }
    
    
}
