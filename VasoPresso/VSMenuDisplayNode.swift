//
//  VSMenuDisplayNode.swift
//  iWallpaper
//
//  Created by Md. Mamun-Ur-Rashid on 6/4/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit


protocol VSMenuDisplayNodeDelegate: class {
    func didSelectedItem(withItem item: VSMenuItem?)
}

class VSMenuDisplayNode: UICollectionView  {

    var items : NSMutableArray = []
    let reuseIdentifier = "VSMenuCell"
    
    var flowLayout : UICollectionViewFlowLayout?
    var selectionDelegate : VSMenuDisplayNodeDelegate?
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       self.setUpView()
    }
    
    func setUpView() {
        
        self.setUpCollectionViewLayoutForDisplay()
        self.registerXibForDisplay()
        self.dataSource = self
        self.delegate = self
        self.reloadData()
        
    }
    
    func setUpCollectionViewLayoutForDisplay() {
        
      self.flowLayout = UICollectionViewFlowLayout.init()
      self.flowLayout?.itemSize = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
      self.flowLayout?.scrollDirection = UICollectionViewScrollDirection.vertical
      self.collectionViewLayout = self.flowLayout!
        
    }
    
    func registerXibForDisplay() {
        
        let nibName = UINib(nibName: "VSMenuCell", bundle:nil)
        self.register(nibName, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    func resetInformation() {
      
        if self.items.count > 0 {
            
            self.items.removeAllObjects()
            self.reloadData()
            self.collectionViewLayout.invalidateLayout()
        }
    }

    
    func addItems(items:NSArray) {
        self.resetInformation()
        if items.count > 0 {
            self.items.addObjects(from:items as! [Any])
            self.reloadData()
         
            
        }
        
    }

}

extension VSMenuDisplayNode : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        let screenWidth = self.bounds.width/2.0;
        return CGSize.init(width: screenWidth, height: screenWidth*0.58)
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
     return 0;
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
     return 0;
    
    }
    
}

extension VSMenuDisplayNode : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
    
        return 1
    
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! VSMenuCell
        let item = self.items[indexPath.row] as! VSMenuItem
        cell.setInformationOnView(withItem: item)
        cell.layoutIfNeeded()
        cell.setNeedsDisplay()
        return cell
    }
    
    
}

extension VSMenuDisplayNode : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedMenuItem  = self.items[indexPath.item];
        self.selectionDelegate?.didSelectedItem(withItem: selectedMenuItem as? VSMenuItem)

    }
    
}



