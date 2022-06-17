import SwiftUI

struct BundlesBrowser_Grid: View {
    let models: [ViewModel.Bundle]
    let showAsPurchased: Bool
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
                                    NavigationLink(destination: BundleViewer(model: ViewModel.Bundle(SampleData.bundle(forID: model.id)!))) {
                                        BundlesBrowser_GridItem(model: model, showAsPurchased: showAsPurchased)
                                    }
                                } else {
                                    BundlesBrowser_GridItem(model: model, showAsPurchased: showAsPurchased)
                                        .onTapGesture {
                                            onTap?(SampleData.bundle)
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
        let models = bundles.map {ViewModel.Bundle($0)}
        VStack {
            BundlesBrowser_Grid(models: models, showAsPurchased: false)
                .preferredColorScheme(.dark)
        }
            .previewLayout(.fixed(width: 900, height: 520))
            .previewDisplayName("Bundles Grid")
    }
}
