//
//  ResultRecipesListViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 12/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class ResultRecipesListViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var resultRecipeListTableView: UITableView!
    
    //MARK: - Properties
    var matchingRecipes = [Matches]()
    var detailedRecipe: DetailedRecipe!
    var detailedRecipeService = DetailedRecipeService()
  
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setResultRecipesTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resultRecipeListTableView.reloadData()
    }
    
    //MARK: - Methods
    //Method to display the navigation item's title
    private func setResultRecipesTableView() {
        self.navigationItem.title = "List of Recipes"
    }
    //Method to get the detailed recipe by tapping a cell into the table view
    private func getDetailsForRecipe(id: String) {
        detailedRecipeService.getDetailedRecipe(id: id) { (success, detailedRecipe)  in
            if success {
                self.detailedRecipe = detailedRecipe
                self.performSegue(withIdentifier: SeguesIdentifiers.detailedRecipeSegueidentifier, sender: self)
            } else {
                self.showAlert(title: "Error", message: "Recipes Details data download failed!")
            }
        }
    }
    //Method to pass datas from the ResultRecipesListViewController to the DetailedRecipesViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SeguesIdentifiers.detailedRecipeSegueidentifier,
            let detailedRecipeVC = segue.destination as? DetailedRecipeViewController, let indexPath = self.resultRecipeListTableView.indexPathForSelectedRow {
            let selectedRecipe = matchingRecipes[indexPath.row]
            detailedRecipeVC.detailedRecipe = detailedRecipe
            detailedRecipeVC.matchingRecipe = selectedRecipe
        }
    }
}
//Extension to setup the resultRecipeListTableView
extension ResultRecipesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultRecipeListTableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.recipeCellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.searchRecipeCellConfigure(recipeName: matchingRecipes[indexPath.row].recipeName,
                       recipeDetails: matchingRecipes[indexPath.row].ingredients,
                       ratings: matchingRecipes[indexPath.row].rating,
                       timer: matchingRecipes[indexPath.row].totalTimeInSeconds / 60,
                       backgroundRecipeImageURL:
            matchingRecipes[indexPath.row].imageUrlsBySize.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getDetailsForRecipe(id: matchingRecipes[indexPath.row].id)
    }
}

