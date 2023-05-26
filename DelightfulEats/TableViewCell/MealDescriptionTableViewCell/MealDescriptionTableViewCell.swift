//
//  MealDescriptionTableViewCell.swift
//  DelightfulEats
//
//  Created by Илья Петров on 25.05.2023.
//

import UIKit

class MealDescriptionTableViewCell: UITableViewCell, Reusable, InterfaceBuilderPrototypable {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with description: String, name: String) {
        let attributedString = NSMutableAttributedString(string: "\(name) \(description)")
        
        // Set bold font for the name
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0)]
        attributedString.addAttributes(boldFontAttribute, range: NSRange(location: 0, length: name.count))
        
        descriptionLabel.attributedText = attributedString
    }
    
}
