import SwiftUI

struct SharedInstagramView: View {
    @State var book: Book
    
    var body: some View {
        VStack {
            Image(uiImage: book.imageCover!)
                .resizable()
                .cornerRadius(7.7)
                .frame(width: 169, height: 242)
                .padding(.bottom)
            Text(book.authors[0])
                .textCase(.uppercase)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 350)
                .padding(.bottom, 10)
            Text(book.title)
                .font(.system(size: 21, weight: .medium, design: .serif))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 350)
            Image("seekerInsta")
                .resizable()
                .frame(width: 144, height: 55)
                .padding([.bottom, .top])
        }
    }
}

extension View {
    func toImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = UIScreen.main.bounds.size
        view?.frame = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let image = renderer.image { _ in
            view?.drawHierarchy(in: CGRect(origin: .zero, size: targetSize), afterScreenUpdates: true)
        }
        return image
    }
}

func shareImageOnInstagramStories(imageData: Data) {
    let appIDString = "290597256711224"
    
    guard let urlScheme = URL(string: "instagram-stories://share?source_application=\(appIDString)") else { return }
    
    if UIApplication.shared.canOpenURL(urlScheme) {
        let pasteboardItems: [[String: Any]] = [
            [
                "com.instagram.sharedSticker.stickerImage": imageData,
                "com.instagram.sharedSticker.backgroundTopColor": "#000000",
                "com.instagram.sharedSticker.backgroundBottomColor": "#000000"
            ]
        ]
        let pasteboardOptions: [UIPasteboard.OptionsKey: Any] = [.expirationDate: Date(timeIntervalSinceNow: 60 * 5)]
        UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
        UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
    } else {
        
    }
}
