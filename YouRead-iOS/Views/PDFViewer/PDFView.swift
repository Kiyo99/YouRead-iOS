import SwiftUI

struct PDFView: View {
    let pdfURL: URL
    
    var body: some View {
        PDFViewRepresentable(pdfURL: pdfURL)
            .ignoresSafeArea(.all)
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView(pdfURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/kbooks-d91c6.appspot.com/o/Books%2FThe%20Rise%20of%20Kyoshi.pdf?alt=media&token=9b6f0e55-a66a-4a8f-bb9a-7fe9124fcf75")!)
    }
}
