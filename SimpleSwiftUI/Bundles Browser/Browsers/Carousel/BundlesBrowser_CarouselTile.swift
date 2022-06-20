import SwiftUI

struct BundlesBrowser_CarouselTile: View {
    let model: ViewModel.Bundle
    let showAsPurchased: Bool
    var cornerRadius: Double = 30
    var body: some View {
        VStack(spacing:0) {
            BundlesBrowser_GridItem(model: model, showAsPurchased: showAsPurchased)
        }
       .background(.black)
        .cornerRadius(cornerRadius)
   }
}

struct BundlesBrowser_CarouselTile_Previews: PreviewProvider {
    static var previews: some View {
        let model = ViewModel.samples.randomBundle
        VStack {
            BundlesBrowser_CarouselTile(model: model, showAsPurchased: false)
        }
        .preferredColorScheme(.dark)
//        .previewLayout(.fixed(width: 900, height: 520))
        .previewDisplayName("Bundles Carousel Tile")
    }
}
