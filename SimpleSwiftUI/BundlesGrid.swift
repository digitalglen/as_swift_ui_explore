import SwiftUI

struct BundlesGrid: View {
    let models: [BundlesGridItemViewModel]
    let showAsPurchased: Bool
    let onTap: ((_ bundle: SampleBundle) -> Void)?

    var body: some View {
        let bundleColumns = Array(repeating: GridItem(.flexible(), spacing: 80, alignment: .center), count: 4)
        ScrollView {
            VStack {
                HStack {
                    Spacer(minLength: 20)
                    LazyVGrid(columns: bundleColumns, spacing: 10) {
                        ForEach(models, id: \.self) { model in
                            BundlesGridItem(model: model, showAsPurchased: showAsPurchased)
                            .onTapGesture {
                                onTap?(SampleData.sampleBundle)
                            }
                        }
                    }
                    Spacer(minLength: 20)
                }
            }
            .padding(20)
        }
    }
}

struct BundlesGrid_Previews: PreviewProvider {
    static var previews: some View {
        let bundles = Array(SampleData.bundles[0...4])
        let models = BundlesGridViewModel(bundles).bundles
        VStack {
            BundlesGrid(models: models, showAsPurchased: false, onTap: nil)
                .preferredColorScheme(.dark)
        }
            .previewLayout(.fixed(width: 900, height: 520))
            .previewDisplayName("Bundles Grid")
    }
}
