import SwiftUI

struct BundlesBrowser_GridItem: View {
    let model: ViewModel.Bundle
    let showAsPurchased: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            SquareImagesGrid(imageNames: model.artworks.map {$0.imageSquareName})
            Footer(title: model.title, price: showAsPurchased ? nil : model.price)
        }
    }
    struct Footer: View {
        let title: String
        let price: String?
        var body: some View {
            HStack {
                VStack {
                    Text(title)
                        .foregroundColor( .primary )
                    if let price = price {
                        Text(price)
                            .foregroundColor( .secondary )
                    } else {
                        Text(" ")
                    }
                }
            }
        }
    }
}

struct BundlesGridItem_Previews: PreviewProvider {
    static var previews: some View {
        let model = ViewModel.samples.bundle
        HStack(alignment: .top) {
            BundlesBrowser_GridItem(model: model, showAsPurchased: false)
                .padding([.all], 20)
                .preferredColorScheme(.dark)

            Divider()
                .background(.primary)

            BundlesBrowser_GridItem(model: model, showAsPurchased: true)
                .padding([.all], 20)
        }
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 500, height: 350))
        .previewDisplayName("Bundles Grid Item")
    }
}
