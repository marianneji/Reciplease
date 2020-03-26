//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Graphic Influence on 18/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var containerView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCellFromSearch (_ recipe: Hit) {
        setRoundedView()
        recipeTitleLabel.text = recipe.recipe.label
        if let stringUrl = URL(string: recipe.recipe.image) {
            recipeImageView.load(url: stringUrl)
        }

        guard recipe.recipe.totalTime != 0  else {
            timeLabel.isHidden = true
            return
        }
        timeLabel.isHidden = false
        timeLabel.text = stringOfMinToHours(minutes: recipe.recipe.totalTime)
    }

    func setupCellFromFavorites(_ recipe: FavoriteRecipes) {
        setRoundedView()
        recipeTitleLabel.text = recipe.label
        guard let time = recipe.totalTime else  {return}
        guard let timetotal = Int(time) else { return }
        guard timetotal != 0 else {
            timeLabel.isHidden = true
            return
        }
        timeLabel.isHidden = false
        timeLabel.text = stringOfMinToHours(minutes: timetotal)
        guard let imageUrl = recipe.image else {
            print("no url image")
            return }
        if let stringUrl = URL(string: imageUrl) {
            recipeImageView.load(url: stringUrl)
        } else {
            
        }

    }

    func stringOfMinToHours(minutes: Int) -> String {
        let h = minutes / 60
        let m = minutes % 60
        if h == 0 {
            return "\(m)m"
        } else if m == 0 {
            return "\(h)H"
        } else {
            return "\(h)H" + "\(m)m"
        }
    }

    func setRoundedView() {
        containerView.layer.cornerRadius = 20
        recipeImageView.layer.cornerRadius = 20
    }

}
