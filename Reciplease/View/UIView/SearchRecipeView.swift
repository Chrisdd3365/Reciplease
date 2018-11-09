//
//  SearchRecipeView.swift
//  Reciplease
//
//  Created by Christophe DURAND on 09/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class SearchRecipeView: UIView {

    //MARK: - Outlets
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchForRecipesButton.isHidden = shown
    }
}
