//
//  VSPickerController.swift
//  CustomAlertView
//
//  Created by IPVision on 8/7/18.
//  Copyright © 2018 dluque. All rights reserved.
//

import UIKit

class VSPickerController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    var delegate: VSAlertViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        picker.delegate = self
        picker.dataSource = self
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
//        cancelButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
//        cancelButton.addBorder(side: .Right, color: alertViewGrayColor, width: 1)
//        okButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
    }
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    @IBAction func onTapCancelButton(_ sender: Any) {
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
      
      //  delegate?.okButtonTapped(selectedOption: selectedOption, textFieldValue: alertTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}

extension VSPickerController : UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "kg"
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
    
    
}

extension VSPickerController : UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
   
    
}
