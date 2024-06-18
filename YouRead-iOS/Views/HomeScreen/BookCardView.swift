import SwiftUI

struct BookCardView: View {
    let imageURL: String
    let title: String
    let author: String
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 150)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(title)
                .font(.headline)
                .padding(.top, 5)
                .lineLimit(2)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
            
            Text(author)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 150)
    }
}

struct BookCardView_Previews: PreviewProvider {
    static var previews: some View {
        BookCardView(
            imageURL: "https://firebasestorage.googleapis.com/v0/b/kbooks-d91c6.appspot.com/o/Images%2F55399.jpg?alt=media&token=4d01cfb8-8bc2-40b9-8761-c9c9c41c3105",
            title: "Gardens of the Moonnnnnnnnnnnnnnnnnnn",
            author: "Steven Erikson"
        )
    }
}
