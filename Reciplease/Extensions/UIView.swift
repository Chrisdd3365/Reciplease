//
//  UIView.swift
//  Reciplease
//
//  Created by Christophe DURAND on 19/09/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //Setup little black box layer
    func viewConfigure(view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(red: 222/255, green: 225/255, blue: 227/255, alpha: 1).cgColor
    }
}
