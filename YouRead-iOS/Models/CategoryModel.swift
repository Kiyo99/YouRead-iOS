//
//  CategoryModel.swift
//  firebase_example_swiftUI
//
//  Created by Godsfavour Ngo Kio on 2024-06-16.
//

import Foundation

struct CategoryModel: Identifiable, Codable {
    var id = UUID()
    let categoryName: String
    var imageName: String
    var primary: Bool
    
    mutating func setPrimary(_ value: Bool){
        primary = value
    }
    
}
