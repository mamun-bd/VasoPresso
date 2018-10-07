//
//  UIStoryboard+Addition.swift
//  iWallpaper
//
//  Created by Md. Mamun-Ur-Rashid on 6/4/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main)
    }

}
