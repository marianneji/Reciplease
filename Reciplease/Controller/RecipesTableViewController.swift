//
//  RecipesTableViewController.swift
//  Reciplease
//
//  Created by Graphic Influence on 18/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    
    @IBOutlet var recipesTableView: UITableView!

    var recipeData: RecipeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipesTableView.register(nibName, forCellReuseIdentifier: "recipeCell")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let totalRecipes = recipeData?.hits.count else {
            didFailWithError(message: RecipeSearchManager.messageError)
            return 0
        }
        return totalRecipes
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        guard let recipeUnwrap = recipeData else { return UITableViewCell()}
        let hit = recipeUnwrap.hits[indexPath.row]
        cell.setupCellFromSearch(hit)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailRecipe", sender: recipeData?.hits[indexPath.row])
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "showDetailRecipe" else { return }
        guard let detailVC = segue.destination as? DetailRecipeViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailVC.selectedRecipe = recipeData?.hits[indexPath.row]
        detailVC.vcOne = true
    }

    @IBAction func addMoreRecipesPressed(_ sender: UIBarButtonItem) {
        
        
    }
}
