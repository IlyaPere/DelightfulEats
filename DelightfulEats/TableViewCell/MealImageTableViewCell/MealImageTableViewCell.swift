//
//  MealImageTableViewCell.swift
//  DelightfulEats
//
//  Created by Илья Петров on 25.05.2023.
//

import UIKit
import Kingfisher

class MealImageTableViewCell: UITableViewCell, Reusable, InterfaceBuilderPrototypable {
    
    // MARK: - Outlets

    @IBOutlet weak var mealImageView: UIImageView!

    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configuration

    func configure(with imageUrl: String) {
        if let url = URL(string: imageUrl) {
            mealImageView.kf.setImage(with: url)
        }
    }
}

