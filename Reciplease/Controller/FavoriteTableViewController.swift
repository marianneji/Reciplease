//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Graphic Influence on 25/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController {

    var coreDataManager: CoreDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "recipeCell")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        guard coreDataManager?.favoriteRecipes.count != 0  else {
            didFailWithError("", message: "No favorites recipes... Click on the 👍 on one recipe to add it to your favorites")
            return
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoriteRecipes.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        guard let favoriteRecipes = coreDataManager?.favoriteRecipes[indexPath.row] else { return UITableViewCell()}
        cell.setupCellFromFavorites(favoriteRecipes)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipe = coreDataManager?.favoriteRecipes[indexPath.row].label else { return }
            coreDataManager?.deleteRecipeFromFavorite(recipeLabel: recipe )
            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailFavoriteRecipe", sender: coreDataManager?.favoriteRecipes[indexPath.row])
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetailFavoriteRecipe" else { return }
        guard let detailVC = segue.destination as? DetailRecipeViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailVC.favoriteRecipe = coreDataManager?.favoriteRecipes[indexPath.row]
        detailVC.vcOne = false
    }
}
