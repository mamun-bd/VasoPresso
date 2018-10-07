//
//  VSVasoPressoController.swift
//  VasoPresso
//
//  Created by Scrupulous on 7/7/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit

class VSVasoPressoController: UIViewController {

    class func initWithStoryboard() -> VSVasoPressoController {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "VSVasoPressoController") as! VSVasoPressoController
        return controller ;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
