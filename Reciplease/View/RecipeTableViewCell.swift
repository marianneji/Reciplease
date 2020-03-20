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


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell (_ recipe: Hit) {

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

}
