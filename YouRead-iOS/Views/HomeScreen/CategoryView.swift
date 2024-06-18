//
//  CategoryView.swift
//  firebase_example_swiftUI
//
//  Created by Godsfavour Ngo Kio on 2024-06-16.
//

import SwiftUI

struct CategoryView: View {
    
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    let category: CategoryModel
    
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: category.imageName)
                .resizable()
                .foregroundStyle(category.primary == true ? .purple: .gray)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            Text(category.categoryName)
                .foregroundStyle(category.primary == true ? .white: .gray)
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(category.primary ? .indigo : .white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .contentShape(Rectangle())
        .onTapGesture {
            categoryViewModel.updatePrimaryCategory(category)
        }
  
    }
}


struct CategoryView_previews: PreviewProvider{
   
    static var previews: some View{
        let dummyCategory = CategoryModel(categoryName: "Ipad", imageName: "ipad", primary: true)
        
        CategoryView(category: dummyCategory)
    }
}
