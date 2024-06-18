//
//  ContentView.swift
//  YouRead-iOS
//
//  Created by Godsfavour Ngo Kio on 2024-06-18.
//
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct HomeView: View {
    @StateObject private var categoryViewModel = CategoryViewModel()
    @State private var books: [BookModel] = []
    
    
    
    var body: some View {
        ZStack {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 10) {
                    //title is the navigation link, so it won't show in previews
                    
                    //Categories
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(categoryViewModel.categories) { category in CategoryView(category: category)
                                    .environmentObject(categoryViewModel)
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    
                    //Library and See all row
                    HStack{
                        Text("Library")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                        Button{
                            //Code to see all
                        } label: {
                            Text("See all")
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    
                    //All books
                    ScrollView(.horizontal){
                        HStack(){
                            ForEach(books){book in
                                NavigationLink(destination: SummaryView(book: book)){
                                    BookCardView(imageURL: book.imageURL, title: book.title, author: book.author)
                                        .frame(width: 150)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                    Spacer().frame(height: 30)
                    
                    //Library and See all row
                    HStack{
                        Text("Recent books")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                        Button{
                            //Code to see all
                        } label: {
                            Text("See all")
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    
                    //All books
                    ScrollView(.horizontal){
                        HStack(){
                            ForEach(books){book in
                                NavigationLink(destination: SummaryView(book: book)){
                                    BookCardView(imageURL: book.imageURL, title: book.title, author: book.author)
                                        .frame(width: 150)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                }                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationTitle("For You")
        .task {
            await categoryViewModel.getCategories()
            await getBooks()
        }
        
    }
    
    func getBooks() async {
        let db = Firestore.firestore()
        
        do {
            let snapshot = try await db.collection("books").getDocuments()
            let fetchedBooks = snapshot.documents.compactMap{doc -> BookModel? in
                let data = doc.data()
                guard let title = data["title"] as? String,
                      let author = data["author"] as? String,
                      let imageurl = data["url"] as? String,
                      let synopsis = data["synopsis"] as? String,
                      let pdfURL = data["storage"] as? String
                else {
                    return nil
                }
                
                return BookModel(id: doc.documentID, title: title, author: author, imageURL: imageurl, synopsis: synopsis, pdfURL: pdfURL)
            }
            
            books = fetchedBooks
            
        } catch {
            print(error)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//#Preview {
//    HomeView()
//}

