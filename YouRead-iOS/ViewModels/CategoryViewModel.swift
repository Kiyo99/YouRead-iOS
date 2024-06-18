//
//  CategoryViewModel.swift
//  firebase_example_swiftUI
//
//  Created by Godsfavour Ngo Kio on 2024-06-17.
//

import Foundation
import FirebaseFirestore

class CategoryViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = []
    
    func getCategories() async {
        do {
            let db = Firestore.firestore()
            let docRef = db.collection("categories").document("categories")
            let document = try await docRef.getDocument()
            
            if document.exists {
                let data = document.data()
                if let values = data?["values"] as? [String] {
                    let fetchedCategories = await fetchCategories(from: values)
                    
                    // Update @Published property on the main thread
                    DispatchQueue.main.async {
                        self.categories = fetchedCategories
                    }
                }
            }
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    private func fetchCategories(from values: [String]) async -> [CategoryModel] {
        var fetchedCategories: [CategoryModel] = []
        
        for categoryName in values {
            var imageName = ""
            
            // Assign imageName based on categoryName
            switch categoryName {
            case "Christian":
                imageName = "cross"
            case "Drama":
                imageName = "theatermasks"
            case "Education":
                imageName = "graduationcap"
            case "Fantasy":
                imageName = "wand.and.stars"
            case "Horror":
                imageName = "hand.raised"
            case "Mystery":
                imageName = "questionmark.circle"
            case "Poetry":
                imageName = "text.book.closed"
            case "Romance":
                imageName = "heart"
            case "Adult":
                imageName = "person.2"
            default:
                imageName = "square.grid.2x2"
            }
            
            // Create CategoryModel
            let category = CategoryModel(categoryName: categoryName, imageName: imageName, primary: false) // Default is false
            fetchedCategories.append(category)
        }
        
        return fetchedCategories
    }
    
    func updatePrimaryCategory(_ category: CategoryModel) {
        
        //When you update the categories, you should update the books as well based on their categories
        
        let currentCategoryIndex = categories.firstIndex(where: {$0.primary == true})
        
        // Set primary = false for all categories
        categories.indices.forEach { index in
            categories[index].setPrimary(false)
        }
        
        // Set primary = true for selected category
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            //checking if current category is the clicked one
            if let currentCategoryIndex {
                categories[currentCategoryIndex].categoryName == category.categoryName ? categories[index].setPrimary(false): categories[index].setPrimary(true)
            } else {
                categories[index].setPrimary(true)
            }
        }
    }
}
