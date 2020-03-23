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

    var favoriteRecipe = FavoriteRecipes.all

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "recipeCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipe = FavoriteRecipes.all
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteRecipe.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCellFromFavorites(favoriteRecipe[indexPath.row])

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            AppDelegate.viewContext.delete(favoriteRecipe[indexPath.row])
            favoriteRecipe.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            do {
                try AppDelegate.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailFavoriteRecipe", sender: favoriteRecipe[indexPath.row])
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "showDetailFavoriteRecipe" else { return }
        guard let detailVC = segue.destination as? DetailRecipeViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailVC.favoriteRecipe = favoriteRecipe[indexPath.row]
        detailVC.vcOne = false
    }

}
