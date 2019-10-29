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
    
    //MARK: - Method
    //Method to setup the activity indicator
    func toggleActivityIndicator(shown: Bool) {
        if shown == false {
            activityIndicator.isHidden = !shown
            activityIndicator.stopAnimating()
            searchForRecipesButton.isHidden = shown
        } else {
            activityIndicator.isHidden = !shown
            activityIndicator.startAnimating()
            searchForRecipesButton.isHidden = shown
        }
    }
}
