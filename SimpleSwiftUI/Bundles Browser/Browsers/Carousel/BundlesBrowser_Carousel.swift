import SwiftUI

struct BundlesBrowser_Carousel: View {
    let models: [ViewModel.Artwork]
    let showAsPurchased: Bool
    var onTap: ((_ bundle: SampleBundle) -> Void)? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundImage()
                
                ScrollView([.horizontal], showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(models) {model in
                            BundlesBrowser_CarouselTile(model: model)
                        }
                    }
                }
//                .background(.orange)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    struct BackgroundImage: View {
        var body: some View {
            Image("background-patterned")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.25)
        }
    }
}

struct BundlesBrowser_Carousel_Previews: PreviewProvider {
    static var previews: some View {
        let models = ViewModel.samples.randomBundle.artworks
        VStack {
            BundlesBrowser_Carousel(models: models, showAsPurchased: false)
        }
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 900, height: 520))
        .previewDisplayName("Bundles Carousel")
    }
}
