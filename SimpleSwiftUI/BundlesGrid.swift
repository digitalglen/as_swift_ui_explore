import SwiftUI

struct BundlesGrid: View {
    typealias TapDestination = ViewBuilder
    let models: [BundlesGridItemViewModel]
    let showAsPurchased: Bool
    let tapDestination: ViewBuilder? = nil
    var onTap: ((_ bundle: SampleBundle) -> Void)? = nil

    var body: some View {
        let bundleColumns = Array(repeating: GridItem(.flexible(), spacing: 80, alignment: .center), count: 4)
        ScrollView {
            VStack {
                HStack {
                    Spacer(minLength: 20)
                        LazyVGrid(columns: bundleColumns, spacing: 10) {
                            ForEach(models, id: \.self) { model in
                                if onTap == nil {
                                    NavigationLink(destination: BundleViewer(bundle: SampleData.sampleBundle(forID: model.id)!)) {
                                        BundlesGridItem(model: model, showAsPurchased: showAsPurchased)
                                    }
                                } else {
                                    BundlesGridItem(model: model, showAsPurchased: showAsPurchased)
                                        .onTapGesture {
                                            onTap?(SampleData.sampleBundle)
                                        }
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
            BundlesGrid(models: models, showAsPurchased: false)
                .preferredColorScheme(.dark)
        }
            .previewLayout(.fixed(width: 900, height: 520))
            .previewDisplayName("Bundles Grid")
    }
}
