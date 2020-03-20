//
//  ViewController.swift
//  Reciplease
//
//  Created by Graphic Influence on 25/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView! { didSet { ingredientTableView.tableFooterView = UIView() }}
    @IBOutlet weak var searchButton: UIButton!

    var recipeManager = RecipeSearchManager()
    var recipeData: RecipeData?
    var ingredients = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.reloadData()
        ingredientTextField.delegate = self
        


    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let ingredient = ingredientTextField.text else { return }
        ingredients.append(ingredient)
        ingredientTableView.reloadData()
        ingredientTextField.resignFirstResponder()
    }
    
    @IBAction func getRecipePressed(_ sender: UIButton) {
        recipeManager.getRecipe(ingredients: ingredients.joined(separator: ",")) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("\(error) in result...ou là")
                case .success(let recipesData):
                    self.recipeData = recipesData
                    self.performSegue(withIdentifier: "toAllRecipes", sender: nil)
                    for hit in self.recipeData!.hits {
                        print("\(String(describing: hit.recipe.label))")
                    }


                }
            }

        }

    }
    @IBAction func clearPressed(_ sender: UIBarButtonItem) {
        ingredients.removeAll()
        ingredientTableView.reloadData()
    }
    @IBAction func vegetarianSwitch(_ sender: UISwitch) {
    }
}

extension IngredientViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ingredientCellId, for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           ingredients.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "toAllRecipes" else { return }
        guard let recipesVC = segue.destination as? RecipesTableViewController else { return }
        recipesVC.recipeData = recipeData

        }

}

extension IngredientViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }

}

