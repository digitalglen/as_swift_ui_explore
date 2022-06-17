import SwiftUI

struct BundlesGridItem: View {
    let model: BundlesGridItemViewModel
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
        let model = BundlesGridItemViewModel(SampleData.sampleBundle)
        HStack(alignment: .top) {
            BundlesGridItem(model: model, showAsPurchased: false)
                .padding([.all], 20)
                .preferredColorScheme(.dark)

            Divider()
                .background(.primary)

            BundlesGridItem(model: model, showAsPurchased: true)
                .padding([.all], 20)
        }
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 500, height: 350))
        .previewDisplayName("Bundles Grid Item")
    }
}
