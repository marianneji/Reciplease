//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Graphic Influence on 18/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!

    @IBOutlet weak var ingredientsTextView: UITextView!
    var selectedRecipe: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }

    func setUpView() {
        guard let recipe = selectedRecipe else { return }
        self.title = recipe.recipe.label
        if let stringUrl = URL(string: recipe.recipe.image) {
            recipeImageView.load(url: stringUrl)
        }
        for (index,ingredients) in recipe.recipe.ingredientLines.enumerated() {
            ingredientsTextView.text += "\(index + 1) : \(ingredients)\n"
            print("\(index + 1) : \(ingredients)\n")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func getDirectionsPressed(_ sender: UIButton) {
        guard let recipe = selectedRecipe else { return }
        guard let url = URL(string: recipe.recipe.url) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func favoritePressed(_ sender: UIBarButtonItem) {
    }
}
