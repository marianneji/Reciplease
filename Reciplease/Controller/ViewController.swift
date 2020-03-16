//
//  ViewController.swift
//  Reciplease
//
//  Created by Graphic Influence on 25/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView! { didSet { ingredientTableView.tableFooterView = UIView() }}


    var recipeData: RecipeData?
    var ingredients = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.reloadData()

    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let ingredient = ingredientTextField.text else { return }
        ingredients.append(ingredient)
        ingredientTableView.reloadData()
        print(ingredients.count)
    }
    
    @IBAction func getRecipePressed(_ sender: UIButton) {
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ingredientCellId, for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}

