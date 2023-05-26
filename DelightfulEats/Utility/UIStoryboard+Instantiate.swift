//
//  UIStoryboard+Instantiate.swift
//  DelightfulEats
//
//  Created by Илья Петров on 24.05.2023.
//

import UIKit

// MARK: - Storyboards

enum Storyboard: String {
    case dishDetailsVC = "DishDetailsVC"
}

extension UIStoryboard {
    convenience init(_ story: Storyboard) {
        self.init(name: story.rawValue, bundle: nil)
    }
    
    func instantiateController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not load view controller with identifier \(String(describing: T.self))")
        }
        return viewController
    }
}

