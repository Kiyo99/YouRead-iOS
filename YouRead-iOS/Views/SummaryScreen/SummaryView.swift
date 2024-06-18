////
////  SummaryView.swift
////  firebase_example_swiftUI
////
////  Created by Godsfavour Ngo Kio on 2024-06-16.
////
//
//import Foundation
//import SwiftUI
//

import SwiftUI

struct SummaryView: View {
    let book: BookModel
    @State private var isShowingPDF = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView(.vertical) {
                Text("By \(book.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                AsyncImage(url: URL(string: book.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 200, height: 300) // Adjust frame size as needed
                
                Spacer()
                
                Text("Synopsis")
                    .bold()
                    .font(.title2)
                
                Spacer()
                
                Text(book.synopsis)
            }
            
            Button {
                isShowingPDF = true
            } label: {
                Text("Read")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .sheet(isPresented: $isShowingPDF) {
                if let url = URL(string: book.pdfURL) {
                    PDFView(pdfURL: url)
                } else {
                    Text("Invalid PDF URL")
                }
            }
        }
        .padding()
        .navigationTitle(book.title)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let book = BookModel(id: "The Rise of Kyoshi", title: "The Rise of Kyoshi", author: "Favour Kio", imageURL: "https://firebasestorage.googleapis.com/v0/b/kbooks-d91c6.appspot.com/o/Images%2Fkyoshi.jpg?alt=media&token=8b23d3e6-7653-4981-b6c6-3cb1cb87987e", synopsis: "F. C. Yee's The Rise of Kyoshi delves into the story of Kyoshi, the Earth Kingdom–born Avatar. The longest-living Avatar in this beloved world's history, Kyoshi established the brave and respected Kyoshi Warriors, but also founded the secretive Dai Li, which led to the corruption, decline, and fall of her own nation.", pdfURL: "https://firebasestorage.googleapis.com/v0/b/kbooks-d91c6.appspot.com/o/Books%2FThe%20Rise%20of%20Kyoshi.pdf?alt=media&token=9b6f0e55-a66a-4a8f-bb9a-7fe9124fcf75")
        
        SummaryView(book: book)
    }
}



//#Preview {
//    let bookkk = BookModel(id: "The Rise of Kyoshi", title: "The Rise of Kyoshi", author: "Favour Kio", imageURL: "https://firebasestorage.googleapis.com/v0/b/kbooks-d91c6.appspot.com/o/Images%2Fkyoshi.jpg?alt=media&token=8b23d3e6-7653-4981-b6c6-3cb1cb87987e", synopsis: "F. C. Yee's The Rise of Kyoshi delves into the story of Kyoshi, the Earth Kingdom–born Avatar. The longest-living Avatar in this beloved world's history, Kyoshi established the brave and respected Kyoshi Warriors, but also founded the secretive Dai Li, which led to the corruption, decline, and fall of her own nation.", pdfURL: "https://firebasestorage.googleapis.com/v0/b/kbooks-d91c6.appspot.com/o/Books%2FThe%20Rise%20of%20Kyoshi.pdf?alt=media&token=9b6f0e55-a66a-4a8f-bb9a-7fe9124fcf75")
//    SummaryView(book: bookkk)
//}
