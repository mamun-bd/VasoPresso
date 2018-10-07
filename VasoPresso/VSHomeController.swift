//
//  VSHomeController.swift
//  VasoPresso
//
//  Created by Scrupulous on 13/7/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit

class VSHomeController: UIViewController {

    @IBOutlet weak var menu : VSMenuDisplayNode!
    var menuItems : NSMutableArray = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        var menuItem = VSMenuItem.init(withType: .adrenaline)
        menuItems.add(menuItem)
        
        menuItem = VSMenuItem.init(withType: .noradrenaline)
        menuItems.add(menuItem)
        
        menuItem = VSMenuItem.init(withType: .dopamine)
        menuItems.add(menuItem)
        
        menuItem = VSMenuItem.init(withType: .dobutamine)
        menuItems.add(menuItem)
        
        menuItem = VSMenuItem.init(withType: .vasopressin)
        menuItems.add(menuItem)
        
    
         self.menu.selectionDelegate = self
        self.menu.addItems(items: menuItems)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  

}

extension VSHomeController : VSMenuDisplayNodeDelegate {
    
    func didSelectedItem(withItem item: VSMenuItem?){
        
        let controller = VSCalculateController.initWithStoryboard(withMenuItem: item)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

