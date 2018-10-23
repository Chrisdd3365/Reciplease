//
//  ResultRecipesListViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 12/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class ResultRecipesListViewController: UIViewController {

    @IBOutlet weak var resultRecipeListTableView: UITableView!
    
    var matchingRecipes = [Matches]()
    var detailedRecipe: DetailedRecipe!
    var detailedRecipeService = DetailedRecipeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setResultRecipesTableViewRowHeight()
        self.navigationItem.title = "List of Recipes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //resultRecipeListTableView.reloadData()
    }
    
    private func getDetailsForRecipe(id: String) {
        detailedRecipeService.getDetailedRecipe(id: id) { (success, detailedRecipe)  in
            if success {
                self.detailedRecipe = detailedRecipe
                self.performSegue(withIdentifier: "detailedRecipeSegue", sender: self)
            } else {
                self.showAlert(title: "Error", message: "Recipes Details data download failed!")
            }
        }
    }
    
    private func setResultRecipesTableViewRowHeight() {
        resultRecipeListTableView.rowHeight = 120
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedRecipeSegue" {
            let detailedRecipesVC = segue.destination as! DetailedRecipesViewController
            detailedRecipesVC.detailedRecipe = detailedRecipe
        }
    }
}

extension ResultRecipesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultRecipeListTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.cellConfigure(recipeName: matchingRecipes[indexPath.row].recipeName,
                       recipeDetails: matchingRecipes[indexPath.row].ingredients,
                       ratings: matchingRecipes[indexPath.row].rating,
                       timer: matchingRecipes[indexPath.row].totalTimeInSeconds / 60,
                       backgroundRecipeImageURL:
            matchingRecipes[indexPath.row].imageUrlsBySize.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getDetailsForRecipe(id: matchingRecipes[indexPath.row].id)
    }
}

