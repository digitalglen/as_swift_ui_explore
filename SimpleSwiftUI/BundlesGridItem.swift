import SwiftUI

struct BundlesGridItem: View {
    let model: BundlesGridItemViewModel
    let showAsPurchased: Bool
    
    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(model.artworks, id: \.self) { model in
                    ZStack(alignment: .top) {
                        SampleViews.image(for: model.imageName)
                            .squared()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .font( .body)
            .cornerRadius(8)
            Footer(title: model.title, price: showAsPurchased ? nil : model.price)
        }
    }
}

extension BundlesGridItem {
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
                    }
                }
            }
        }
    }
}

struct BundlesGridItem_Previews: PreviewProvider {
    static var previews: some View {
        let model = BundlesGridItemViewModel(SampleData.sampleBundle)
        HStack {
            BundlesGridItem(model: model, showAsPurchased: false)
//                .previewLayout(.fixed(width: 200, height: 200))
                .padding([.all], 20)
                .preferredColorScheme(.dark)
            BundlesGridItem(model: model, showAsPurchased: true)
                .previewLayout(.fixed(width: 200, height: 500))
                .padding([.all], 20)
                .preferredColorScheme(.dark)
        }
    }
}
