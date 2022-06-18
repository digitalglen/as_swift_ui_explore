import SwiftUI

struct BundlesBrowser_CarouselTile: View {
    let model: ViewModel.Artwork
    var cornerRadius: Double = 30
    var body: some View {
        VStack(spacing:0) {
            ZStack(alignment: .bottom) {
                model.imageLarge!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
//                HStack {
//                    VStack {
//                        Text(model.title)
//                            .font(.body)
//                    }
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .frame(width: .infinity, height: 100)
//                .background(.thinMaterial)
//                .opacity(0)
            }
            .frame(width: 750, height: 750)
            .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])

            VStack {
                Text(model.title)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: 750)
            .frame(width: .infinity, height: 60)
//            .background(.thinMaterial.opacity(0.5))
        }
        .background(.black)
        .cornerRadius(cornerRadius)
   }
}

struct BundlesBrowser_CarouselTile_Previews: PreviewProvider {
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
