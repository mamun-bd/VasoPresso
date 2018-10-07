//
//  VSMenuCell.swift
//  iWallpaper
//
//  Created by Md. Mamun-Ur-Rashid on 6/4/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit

class VSMenuCell: UICollectionViewCell {

   
    @IBOutlet weak var container:UIView!;
    @IBOutlet weak var shadowView:UIView!;
    
    @IBOutlet weak var lblTitle:UILabel!;
    @IBOutlet weak var iconContainer:UIImageView!;
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.backgroundColor = UIColor.clear
        self.frame = CGRect(x:self.frame.origin.x, y:self.frame.origin.y, width:UIScreen.main.bounds.size.width/3, height:UIScreen.main.bounds.size.width/3);
        self.setNeedsLayout()
        self.needsUpdateConstraints()
        self.shadowView.shadow()
        self.layoutIfNeeded()

    }
    
    func setInformationOnView(withItem item:VSMenuItem){
        
        self.lblTitle.text = item.title
        self.iconContainer.image = UIImage.init(named: item.icon!)
        
    }

}
