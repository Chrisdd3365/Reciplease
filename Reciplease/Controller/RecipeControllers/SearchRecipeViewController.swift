//
//  SearchRecipeViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 05/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var searchRecipeView: SearchRecipeView!
    
    //MARK: - Properties
    var ingredients: [String] = []
    var matchingRecipes: [Matches] = []
    var searchRecipeService = SearchRecipeService()
   
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRecipeView.ingredientsTextField.setBottomBorder()
        searchForRecipeButtonIsEnabled()
        searchRecipeView.toggleActivityIndicator(shown: false)
        registerIngredientsTableView()
    }
    
    //MARK: - Actions
    @IBAction func add(_ sender: UIButton) {
        addIngredientIntoList()
    }
    
    @IBAction func clear(_ sender: UIButton) {
        clearList()
    }
    
    @IBAction func searchForRecipes(_ sender: UIButton) {
        searchRecipe()
    }

    //MARK: - Methods
    private func addIngredientIntoList() {
        guard let inputs = searchRecipeView.ingredientsTextField.text else { return }
        if inputs != "" {
            let ingredients = inputs.components(separatedBy: ", ")
            for ingredient in ingredients {
                let ingredientAddToList = ingredient
                let ingredientName = ingredientAddToList
                self.add(ingredient: ingredientName)
            }
            ingredientsTableView.reloadData()
            searchRecipeView.ingredientsTextField.text = ""
        } else {
            showAlert(title: "Hey!", message: "You need to tell me what's in your fridge first!")
        }
    }
    
    private func add(ingredient: String) {
        ingredients.append(ingredient)
    }
    
    private func clearList() {
        if ingredients.isEmpty == false  {
            ingredients.removeAll()
            ingredientsTableView.reloadData()
            searchRecipeView.searchForRecipesButton.isEnabled = false
            searchRecipeView.searchForRecipesButton.backgroundColor = UIColor.lightGray
        } else {
            showAlert(title: "Hey!", message: "Don't clear what you already don't have!")
        }
    }
    
    private func searchRecipe() {
        searchRecipeService.getRecipe(ingredients: ingredients) { (success, recipes)  in
            self.searchRecipeView.toggleActivityIndicator(shown: true)
            if success, let recipes = recipes {
                self.matchingRecipes = recipes
                self.performSegue(withIdentifier: "recipesResultsSegue", sender: self)
                self.searchRecipeView.toggleActivityIndicator(shown: false)
            } else {
                self.showAlert(title: "Error", message: "Recipes data download failed!")
            }
        }
    }
    
    private func searchForRecipeButtonIsEnabled() {
        searchRecipeView.searchForRecipesButton.isEnabled = false
        searchRecipeView.searchForRecipesButton.backgroundColor = UIColor.lightGray
    }
    
    private func registerIngredientsTableView() {
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ingredientCell")
        ingredientsTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipesResultsSegue" {
            let resultsRecipesVC = segue.destination as! ResultRecipesListViewController
            resultsRecipesVC.matchingRecipes = matchingRecipes
        }
    }
}

extension SearchRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = "- " + "\(ingredient)"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        
        let cellTextLabel = cell.textLabel?.text
        if cellTextLabel?.isEmpty == false {
            searchRecipeView.searchForRecipesButton.isEnabled = true
            searchRecipeView.searchForRecipesButton.backgroundColor = UIColor.init(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
        }
        return cell
    }
}


    




