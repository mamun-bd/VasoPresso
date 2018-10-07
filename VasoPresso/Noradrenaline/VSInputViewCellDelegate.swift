//
//  VSInputViewCellDelegate.swift
//  VasoPresso
//
//  Created by Scrupulous on 14/7/18.
//  Copyright © 2018 Varendra Soft. All rights reserved.
//

import UIKit

protocol VSInputViewCellDelegate: class {
     func didSelectedInputItem(withInformation item: VSInputModel?)
     func didUpdateEnableStatusOfSelectedInputItem(withInformation item: VSInputModel?)
}

