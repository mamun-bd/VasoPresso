//
//  VSCalculateController.swift
//  VP
//
//  Created by IPVision on 7/7/18.
//  Copyright © 2018 IPVision. All rights reserved.
//

import UIKit

class VSCalculateController: UIViewController {

    var taskCell : VSImportViewCell?
    var menuItem : VSMenuItem?
    
    var items : NSMutableArray = []
    var xibInformation:[String:String] = [String:String]()
    
    @IBOutlet weak var taskTableView : UITableView!
     @IBOutlet weak var lblInfusionRate : UILabel!
    @IBOutlet weak var lblTitle:UILabel!;
    @IBOutlet weak var lblInfusion:UILabel!;
    @IBOutlet weak var iconContainer:UIImageView!;
     @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnCalculate: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var optionView: UIView!
    
    @IBOutlet weak var optionsHeight: NSLayoutConstraint!
     @IBOutlet weak var infusionRateHeight: NSLayoutConstraint!
    
     var options : NSMutableArray = []
    
     @IBOutlet weak var shadowView:UIView!;
   
    var selectedSectionIndex : Int!
 
    class func initWithStoryboard(withMenuItem item:VSMenuItem?) -> VSCalculateController {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "VSCalculateController") as! VSCalculateController
        controller.menuItem = item
        return controller ;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.segmentedController.shadow()
        self.sectionView.shadow()
        
         self.shadowView.shadow()
        
        self.buttonView.shadow()
        self.btnHome.shadow()
        self.btnCalculate.shadow()
        self.btnReset.shadow()
        
        self.lblTitle.text = menuItem?.title
        self.iconContainer.image = UIImage.init(named: (menuItem?.icon!)!)
        
        let height = 50 * (menuItem?.options.count)!
        
        optionsHeight.constant = CGFloat(height)
        //infusionRateHeight.constant = 0.0
        self.initializeTableView()
        
        self.selectedSectionIndex = 0
        self.updateOutputStatus()
        self.options.addObjects(from: self.menuItem?.options as! [Any])
        
       //  lblInfusionRate.text =  "Infusion Rate: N/A"
      
    }
    
    func updateOutputStatus() {
        
        if let currentIndex = self.selectedSectionIndex, currentIndex == 1 {
            
            self.lblInfusion.text =  String(format: "Dose");
            
            if let isVasopressin = self.menuItem?.type, isVasopressin == .vasopressin {
                
                self.lblInfusionRate.text =  String(format: "0.0 Unit/min")
                
            } else {
                
                if let isEnable = self.menuItem?.weightItem?.isEnable, isEnable == true {
                    self.lblInfusionRate.text =  String(format: "0.0 mcg/kg/min")
                } else {
                    self.lblInfusionRate.text =  String(format: "0.0 mcg/min")
                }
                
            }
            
            
        } else {
            self.lblInfusion.text =  String(format: "Infusion Rate");
            self.lblInfusionRate.text =  String(format: "0.0 ml/hr")
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calculateButtonAction(_ sender: Any) {
        
        if let currentIndex = self.selectedSectionIndex, currentIndex == 1 {
            
            let result = self.menuItem?.getDose()
            
            if let isVasopressin = self.menuItem?.type, isVasopressin == .vasopressin {
                
                self.lblInfusionRate.text =  String(format: "%.2f Unit/min", result!)
               
            } else {
                
                if let isEnable = self.menuItem?.weightItem?.isEnable, isEnable == true {
                    self.lblInfusionRate.text =  String(format: "%.2f mcg/kg/min", result!)
                } else {
                    self.lblInfusionRate.text =  String(format: "%.2f mcg/min", result!)
                }
                
            }
            
        } else {
            
             let result = self.menuItem?.getInfusionRate()
             self.lblInfusionRate.text =  String(format: "%.2f ml/hr", result!)

        }

    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        
        self.menuItem?.resetInformation()
        self.taskTableView.reloadData()
        lblInfusionRate.text =  String(format: "0.0 ml/hr")
    
    }
    
    @IBAction func sectionButtonAction(_ sender: UISegmentedControl) {
        
        self.selectedSectionIndex = sender.selectedSegmentIndex;
        self.updateOutputStatus()
        self.menuItem?.resetInformation()
        self.options.removeAllObjects()
    
        if let currentIndex = selectedSectionIndex, currentIndex == 1 {
            options.addObjects(from: self.menuItem?.doseOptions as! [Any])
        } else {
            options.addObjects(from: self.menuItem?.options as! [Any])
        }
        
        self.taskTableView.reloadData()
       
    }
   
    
    func initializeTableView() {
        
         self.optionView.shadow()
        
        self.taskTableView.separatorStyle = .none
        self.taskTableView.estimatedRowHeight = 44
        self.taskTableView.rowHeight = UITableViewAutomaticDimension
        
        self.xibInformation["VSImportViewCell"] = "VSImportViewCell"
        self.xibInformation["VSWeightViewCell"] = "VSWeightViewCell"
        for (key,value) in self.xibInformation {
            taskTableView.register(UINib(nibName:key, bundle:Bundle.main), forCellReuseIdentifier:value);
        }
        
        self.taskTableView.delegate = self;
        self.taskTableView.dataSource = self;
    }
    
    
    
    func getCellIdentificationForItem(item:Any) -> [String:String] {
        
        var nibIdentifier = ""
        var nibName = ""
        
        if item is VSInputModel {
            
            let selectedItem = item as? VSInputModel

            if let isNoradrenaline = self.menuItem?.type, isNoradrenaline == .noradrenaline {
                
                if let isEnable = selectedItem?.type, isEnable == .weight {
                    nibIdentifier = "VSWeightViewCell"
                    nibName = "VSWeightViewCell"
                } else {
                    nibIdentifier = "VSImportViewCell"
                    nibName = "VSImportViewCell"
                }
                
                
            } else {
                nibIdentifier = "VSImportViewCell"
                nibName = "VSImportViewCell"
            }
            
            
        }
        
        var xibInfo:[String:String] = [String:String]()
        xibInfo[nibName] = nibIdentifier
        return xibInfo
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}


extension VSCalculateController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.options.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedItem = self.options[indexPath.row] as! VSInputModel
        let nibInfo = self.getCellIdentificationForItem(item: selectedItem)
        
        if let isNoradrenaline = self.menuItem?.type, isNoradrenaline == .noradrenaline {
           
            if let isEnable = selectedItem.type, isEnable == .weight {
                let cell = tableView.dequeueReusableCell(withIdentifier: (nibInfo.values.first)!, for: indexPath) as! VSWeightViewCell
                cell.selectionDelegate = self
                cell.setInformationOnView(withItem: selectedItem)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: (nibInfo.values.first)!, for: indexPath) as! VSImportViewCell
                cell.selectionDelegate = self
                cell.setInformationOnView(withItem: selectedItem)
                return cell
            }
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: (nibInfo.values.first)!, for: indexPath) as! VSImportViewCell
            cell.selectionDelegate = self
            cell.setInformationOnView(withItem: selectedItem)
            return cell
        }

        
    }
    
}

extension VSCalculateController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //        let selectedMenu  = self.menuList[indexPath.row];
        //        let controller = ReceipeViewController.initWithStoryboard(withMenu: selectedMenu as! VSTaskModel)
        //        self.navigationController?.pushViewController(controller, animated: true)
        //        self.menuTableView .deselectRow(at: indexPath, animated: false);
        
    }
    
}

extension VSCalculateController : UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool){
        
        if (!decelerate) {
            self.endDecelerating()
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.endDecelerating()
    }
    
    func endDecelerating() {
        
//        let indexPath = self.taskTableView?.indexPathsForVisibleRows?.last
//        if (((indexPath) != nil) && indexPath?.row == (self.dataSource.getTaskListFromDataStore().count-1)) {
//            NSLog("Next Call");
//        }
    }
    
}

extension VSCalculateController : VSInputViewCellDelegate  {
    
    func didSelectedInputItem(withInformation item: VSInputModel?) {
        
        let customAlert = VSAlertView.initWithStoryboard(withInputInformation: item)
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
        
    }
    
    func didUpdateEnableStatusOfSelectedInputItem(withInformation item: VSInputModel?){
        
        if let isEnable = self.menuItem?.weightItem?.isEnable, isEnable == true {
            self.menuItem?.doseItem?.unit = .mcg_kg_min
        } else {
            self.menuItem?.doseItem?.unit = .mcg_min
        }
        
        self.taskTableView.reloadData()
        self.updateOutputStatus()
        
    }
    
}

extension VSCalculateController: VSAlertViewDelegate {
    
    func okButtonTapped(withInformation item:VSInputModel?) {
      
        let updateIndex = self.options.index(of: item as Any)
        taskTableView.beginUpdates()
        let indexPath = IndexPath(item: updateIndex, section: 0)
        taskTableView.reloadRows(at: [indexPath], with: .none)
        taskTableView.endUpdates()
        
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}



