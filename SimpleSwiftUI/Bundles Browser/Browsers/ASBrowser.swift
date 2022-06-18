import SwiftUI

/*
struct BundleBrowsable: Browsable {
    typealias Model = ViewModel.Artwork
    let items: [Model]
    func view(for model: Model) -> any View {
        ArtworkViewer(model: model)
    }
    
    init(_ bundle: ViewModel.Bundle) {
        self.items = bundle.artworks
    }
}

struct ASBrowser: View  {
    let browsable: any Browsable
    let models: [ViewModel.Artwork]
    let showAsPurchased: Bool
    var onTap: ((_ bundle: SampleBundle) -> Void)? = nil
    let spacing: Double = 40
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    ScrollView([.horizontal], showsIndicators: false) {
                        HStack(spacing: spacing) {
                            ForEach(browsable.items) {model in
                                NavigationLink(destination: ArtworkViewer(model: model)) {
                                    BundlesBrowser_CarouselTile(model: model)
                                }
                            }
                        }
                        .padding(.horizontal, spacing)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .background(Color.gray)
        }
    }
}

struct ASBrowser_Previews: PreviewProvider {
    static var previews: some View {
        let browsable = BundleBrowsable(ViewModel.samples.randomBundle)
        let models = ViewModel.samples.randomBundle.artworks
        VStack {
            ASBrowser(browsable: browsable, models: models, showAsPurchased: false)
        }
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 900, height: 520))
        .previewDisplayName("ASBrowser")
    }
}
*/
