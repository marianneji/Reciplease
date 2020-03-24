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
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!

    var alert = UIAlertController()
    var recipeManager = RecipeSearchManager()
    var recipeData: RecipeData?
    var ingredients = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.reloadData()
        ingredientTextField.delegate = self
//        let attributes = [NSAttributedString.Key.font: UIFont(name: "The Heart Chakra .ttf", size: 20)!]
//        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchButton.isEnabled = true
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let ingredient = ingredientTextField.text else { return }
        if ingredient == "" {
            didFailWithError(message: "Please enter some ingredient")
        } else {
            ingredients.append(ingredient)
            ingredientTableView.reloadData()
        }
        ingredientTextField.resignFirstResponder()
    }
    
    @IBAction func getRecipePressed(_ sender: UIButton) {
        displayAlertActivity(alert: &alert, title: "Loading recipes...\nPlease wait")
        searchButton.isEnabled = false
        recipeManager.getRecipe(ingredients: ingredients.joined(separator: ",")) { (result) in

            DispatchQueue.main.async {
                self.dismissAlertActivity(alert: self.alert) {
                    switch result {
                    case .failure(let error):
                        self.searchButton.isEnabled = true
                        self.didFailWithError(message: RecipeSearchManager.messageError)
                        print("\(error) in result...ou là")
                    case .success(let recipesData):
                        self.recipeData = recipesData
                        if recipesData.hits.count == 0 {
                            self.didFailWithError(message: "No recipes with these ingredients")
                            self.ingredients.removeAll()
                            self.ingredientTableView.reloadData()
                            self.searchButton.isEnabled = true
                        } else {
                            self.performSegue(withIdentifier: "toAllRecipes", sender: nil)
                        }
                    }
                }
            }
        }
    }

    @IBAction func clearPressed(_ sender: UIBarButtonItem) {
        ingredients.removeAll()
        ingredientTableView.reloadData()
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

