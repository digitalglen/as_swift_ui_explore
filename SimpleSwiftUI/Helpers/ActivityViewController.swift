import UIKit
import SwiftUI
import LinkPresentation

struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: [activityItems], applicationActivities: applicationActivities)
//        controller.completionWithItemsHandler = { (_ activity: UIActivity.ActivityType?, _ completed: Bool,_ returnedItems: [Any]?, _ error: Error?) in
//            if let error {
//                print("completionWithItemsHandler error: \(error)")
//            } else {
//                print("completionWithItemsHandler")
//            }
//        }
//        controller.allowsProminentActivity = false
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}

//
//class ShareActivityItemSource: NSObject, UIActivityItemSource {
//    
//    var shareText: String
//    var shareImage: UIImage
//    var shareURL: URL
//    
//    init(shareText: String, shareImage: UIImage, shareURL: URL) {
//        self.shareText = shareText
//        self.shareImage = shareImage
//        self.shareURL = shareURL
//        super.init()
//        print("ShareActivityItemSource")
//        print("• shareText: \(shareText)")
//        print("• shareImage: \(shareImage)")
//        print("• shareURL: \(shareURL)")
//    }
//    
//    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
////        shareImage as Any
//        shareURL
////        UIImage() // an empty UIImage is sufficient to ensure share sheet shows right actions
//    }
//
//    
//    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
//        //        shareImage as Any?
//        shareURL
//    }
//    
//    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
//        let metadata = LPLinkMetadata()
//
//        metadata.title = "Description of image to share" // Preview Title
//        metadata.originalURL = shareURL // determines the Preview Subtitle
//        metadata.url = shareURL
//        metadata.imageProvider = NSItemProvider.init(contentsOf: shareURL)
//        metadata.iconProvider = NSItemProvider.init(contentsOf: shareURL)
//
//        return metadata
//    }
//}
