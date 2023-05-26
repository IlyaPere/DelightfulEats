//
//  DishDetailsVC.swift
//  DelightfulEats
//
//  Created by Илья Петров on 24.05.2023.
//

import UIKit

class DishDetailsVC: UIViewController {
    
    // MARK: - Properties
    
    var meal: Meal?
    var mealDetails: MealDetails?
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Structs
    
    struct Response: Codable {
        let meals: [MealDetails]
    }
    
    struct MealDetails: Codable {
        let idMeal: String
        let strMeal: String
        let strInstructions: String
        
        let strDrinkAlternate: String?
        let strCategory: String
        let strArea: String
        let strMealThumb: String
        let strTags: String?
        let strYoutube: String
        
        let strIngredient1: String?
        let strIngredient2: String?
        let strIngredient3: String?
        let strIngredient4: String?
        let strIngredient5: String?
        let strIngredient6: String?
        let strIngredient7: String?
        let strIngredient8: String?
        let strIngredient9: String?
        let strIngredient10: String?
        let strIngredient11: String?
        let strIngredient12: String?
        let strIngredient13: String?
        let strIngredient14: String?
        let strIngredient15: String?
        let strIngredient16: String?
        let strIngredient17: String?
        let strIngredient18: String?
        let strIngredient19: String?
        let strIngredient20: String?
        
        let strMeasure1: String?
        let strMeasure2: String?
        let strMeasure3: String?
        let strMeasure4: String?
        let strMeasure5: String?
        let strMeasure6: String?
        let strMeasure7: String?
        let strMeasure8: String?
        let strMeasure9: String?
        let strMeasure10: String?
        let strMeasure11: String?
        let strMeasure12: String?
        let strMeasure13: String?
        let strMeasure14: String?
        let strMeasure15: String?
        let strMeasure16: String?
        let strMeasure17: String?
        let strMeasure18: String?
        let strMeasure19: String?
        let strMeasure20: String?
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchMealDetails()
    }
    
    // MARK: - UI Setup
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        
        tableView.separatorStyle = .none
   
        tableView.register(MealImageTableViewCell.self)
        tableView.register(MealDescriptionTableViewCell.self)
    }
    
    // MARK: - Networking
    
    func fetchMealDetails() {
        guard let mealId = meal?.idMeal, let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                
                if let meal = response.meals.first {
                    DispatchQueue.main.async {
                        self?.mealDetails = meal
                        self?.navigationItem.title = meal.strMeal
                        self?.tableView.reloadData()
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

extension DishDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealImageTableViewCell", for: indexPath) as! MealImageTableViewCell
            
            if let mealDetails = mealDetails {
                cell.configure(with: mealDetails.strMealThumb)
            }
            
            return cell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeue(MealDescriptionTableViewCell.self, for: indexPath)
            
            if let mealDetails = mealDetails {
                let name = "Instructions:"
                cell.configure(with: mealDetails.strInstructions, name: name)
            }
            
            return cell
        } else {
            let cell = tableView.dequeue(MealDescriptionTableViewCell.self, for: indexPath)
            
            if let mealDetails = mealDetails {
                var ingredientMeasureText = ""
                let mirror = Mirror(reflecting: mealDetails)
                var ingredientCount = 0
                
                for i in 1...20 {
                    let ingredientKey = "strIngredient\(i)"
                    let measureKey = "strMeasure\(i)"
                    
                    if let ingredient = mirror.children.first(where: { $0.label == ingredientKey })?.value as? String,
                       let measure = mirror.children.first(where: { $0.label == measureKey })?.value as? String {
                        let ingredientMeasure = "\(ingredient) \(measure)"
                        
                        if !ingredientMeasure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                               if !ingredientMeasureText.isEmpty {
                                   ingredientMeasureText += ", "
                               }
                               
                               ingredientMeasureText += ingredientMeasure
                               ingredientCount += 1
                           }
                    }
                }
                
                let name = "Ingredients measurements:"
                cell.configure(with: ingredientMeasureText, name: name)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else {
            return UITableView.automaticDimension
        }
    }
}
