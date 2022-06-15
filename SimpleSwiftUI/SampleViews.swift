import SwiftUI

struct SampleViews {
    static var placeholder: some View {
        SamplePlaceholderView()
    }
    static var placeholderImageName: String {"sample_image_portrait"}
    static var placeholderImage: Image {
        Image("sample_image_portrait")
    }
    static func image(for name: String?) -> Image {
        if let name = name, let uiImage = UIImage(named: name) {
            return Image(uiImage: uiImage)
        } else if let name = name {
            return Image(name)
        } else {
            return placeholderImage
        }
    }
}

private struct SamplePlaceholderView: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background( Color(uiColor: .magenta).opacity(0.25) )
    }
}
