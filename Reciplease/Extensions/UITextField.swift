//
//  UITextField.swift
//  Reciplease
//
//  Created by Christophe DURAND on 22/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

extension UITextField {
    //Method to setup the UI of the text field in SearchRecipeViewController
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
