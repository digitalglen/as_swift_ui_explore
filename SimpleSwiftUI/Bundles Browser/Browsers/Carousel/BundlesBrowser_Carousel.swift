import SwiftUI

struct BundlesBrowser_Carousel: View {
    let models: [ViewModel.Bundle]
    let showAsPurchased: Bool
    let spacing: Double = 40
    var onTap: ((_ bundle: SampleBundle) -> Void)? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                //                BackgroundImage()
                ScrollView([.horizontal], showsIndicators: false) {
                    HStack {
                        Spacer(minLength: spacing)
                        VStack {
                            HStack(spacing: spacing) {
                                ForEach(models) {model in
                                    if onTap == nil {
                                        NavigationLink(destination: BundleViewer(model: ViewModel.Bundle(SampleData.bundle(forID: model.id)!))) {
                                            BundlesBrowser_CarouselTile(model: model, showAsPurchased: showAsPurchased)
                                                .frame(width: geometry.size.width * 0.65)
                                        }
                                    } else {
                                        BundlesBrowser_CarouselTile(model: model, showAsPurchased: showAsPurchased)
                                            .frame(width: geometry.size.width * 0.65)
                                            .onTapGesture {
                                                onTap?(SampleData.bundle)
                                            }
                                    }
                                }
                                .frame(maxHeight: .infinity)
                            }
                        }
                        Spacer(minLength: spacing)
                    }
                }
            }
            .frame(maxHeight: .infinity)
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
        let models = ViewModel.samples.bundles
        VStack {
            BundlesBrowser_Carousel(models: models, showAsPurchased: false)
        }
        .preferredColorScheme(.dark)
//        .previewLayout(.fixed(width: 900, height: 520))
        .previewDisplayName("Bundles Carousel")
    }
}
