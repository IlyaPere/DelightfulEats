//
//  UIKitExtension.swift
//  DelightfulEats
//
//  Created by Илья Петров on 25.05.2023.
//

import UIKit

import UIKit

protocol StoryboardIdentifiable {
    static var identifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol Presentable {
    var toPresent: UIViewController? { get }
}

extension UIViewController: StoryboardIdentifiable {}
extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

protocol InterfaceBuilderPrototypable {
    static var nib: UINib { get }
}

extension InterfaceBuilderPrototypable {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }
}

extension UICollectionView {
    // MARK: - Cell
    func register<T: UICollectionViewCell>(_ : T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_ : T.Type) where T: Reusable, T: InterfaceBuilderPrototypable {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            abort()
        }
        
        return cell
    }
    
    // MARK: - SectionHeader
    
    func register<T: UICollectionReusableView>(_ : T.Type) where T: Reusable, T: InterfaceBuilderPrototypable {
        register(T.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UICollectionReusableView>(_ : T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            abort()
        }
        return header
    }
}

extension UITableView {
    // MARK: - UITableViewCell
    func register<T: UITableViewCell>(_ : T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_ : T.Type) where T: Reusable, T: InterfaceBuilderPrototypable {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewCell>(_ : T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            abort()
        }
        return cell
    }
    
    // MARK: - UITableViewHeaderFooterView
    func register<T: UITableViewHeaderFooterView>(_ : T.Type) where T: Reusable, T: InterfaceBuilderPrototypable {
        register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_ : T.Type) -> T where T: Reusable {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            abort()
        }
        return header
    }
}
