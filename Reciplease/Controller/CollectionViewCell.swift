//
//  CollectionViewCell.swift
//  Reciplease
//
//  Created by Graphic Influence on 13/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var recipeTitleLabel: UILabel!

    func setupCell() {
        contentView.layer.cornerRadius = 20
    }
}
