//
//  VSAlertViewDelegate.swift
//  VSAlertView
//
//  Created by Daniel Luque Quintana on 16/3/17.
//  Copyright © 2017 dluque. All rights reserved.
//

protocol VSAlertViewDelegate: class {
    func okButtonTapped(withInformation item:VSInputModel?)
    func cancelButtonTapped()
}
