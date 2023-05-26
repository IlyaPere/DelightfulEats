//
//  ViewController.swift
//  DelightfulEats
//
//  Created by Илья Петров on 24.05.2023.
//

import UIKit

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

class ViewController: UIViewController, UINavigationBarDelegate {
    
    // MARK: - Properties
    
    var meals: [Meal] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        
        fetchMeals()
    }
    
    // MARK: - UI Setup
    
    private func setupNavigationBar() {
           let navigationController = UINavigationController(rootViewController: self)
           
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
           
           self.navigationItem.title = "Dessert Menu"
       }
       
       private func setupTableView() {
           tableView.register(DishTableViewCell.self)
           tableView.dataSource = self
           tableView.delegate = self
       }
    
    // MARK: - Networking
    
    private func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                
                let filteredMeals = response.meals.filter { meal in
                    return !meal.strMeal.isEmpty && !meal.strMealThumb.isEmpty && !meal.idMeal.isEmpty
                }
                
                let sortedMeals = filteredMeals.sorted { $0.strMeal < $1.strMeal }
                
                self?.meals = sortedMeals
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DishTableViewCell.self, for: indexPath)
        
        let meal = meals[indexPath.row]
        cell.setupWith(meal: meal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        
        let dishDetailsVC = UIStoryboard(.dishDetailsVC).instantiateController() as DishDetailsVC
        dishDetailsVC.meal = meal
        dishDetailsVC.fetchMealDetails()
        navigationController?.pushViewController(dishDetailsVC, animated: true)
    }
}

struct Response: Codable {
    let meals: [Meal]
}
