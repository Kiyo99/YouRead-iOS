//
//  CardView.swift
//  firebase_example_swiftUI
//
//  Created by Godsfavour Ngo Kio on 2024-06-16.
//

import SwiftUI

struct CardView: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100) // Adjust image size as needed
                .foregroundColor(.mint) // Adjust image color
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        
    }
}

struct CardView_Previewss: PreviewProvider {
    static var previews: some View {
        CardView(imageName: "ipad", title: "Ipad", description: "A very long text")
    }
}

