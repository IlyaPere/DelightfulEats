//
//  FoodTableViewCell.swift
//  DelightfulEats
//
//  Created by Илья Петров on 24.05.2023.
//

import UIKit
import Kingfisher

class DishTableViewCell: UITableViewCell, Reusable, InterfaceBuilderPrototypable  {

    // MARK: - Outlets
    
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var numberOrderLabel: UILabel!
    @IBOutlet weak var dichImageView: UIImageView!

    // MARK: - Public Methods
    
    func setupWith(meal: Meal) {
        dishName.text = meal.strMeal
        numberOrderLabel.text = meal.idMeal
        
        if let thumbnailURL = URL(string: meal.strMealThumb) {
            dichImageView.kf.setImage(with: thumbnailURL)
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

