//
//  UIView+Extension.swift
//  iWallpaper
//
//  Created by Md. Mamun-Ur-Rashid on 6/4/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit

//
// Inspectable - Design and layout for View
// cornerRadius, borderWidth, borderColor
//

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
    
    
    func shadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.init(width: 0, height: 1)
      
    }
    
    
  
    
}

    

