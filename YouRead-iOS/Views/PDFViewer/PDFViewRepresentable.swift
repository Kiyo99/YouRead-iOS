import PDFKit
import SwiftUI

struct PDFViewRepresentable: UIViewControllerRepresentable {
    
    let pdfURL: URL
    
    func makeUIViewController(context: Context) -> PDFViewController {
        return PDFViewController()
    }
    
    func updateUIViewController(_ uiViewController: PDFViewController, context: Context) {
        uiViewController.loadPDF(from: pdfURL)
    }
    
}

class PDFViewController: UIViewController {
    var pdfView: PDFKit.PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize PDFView
        pdfView = PDFKit.PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfView)
    }
    
    func loadPDF(from url: URL){
        if let document = PDFDocument(url: url){
            pdfView.document = document
        }
    }
}
