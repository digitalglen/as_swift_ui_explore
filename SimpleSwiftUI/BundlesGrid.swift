import SwiftUI

struct BundlesGrid: View {
    let models: [ArtworksGridDataModel]
    let showAsPurchased: Bool
    let onTap: ((_ bundle: SampleBundle) -> Void)?

    var gridHSpacing: Double {return 80}
    var gridVSpacing: Double {return 10}
        
    init(_ models: [ArtworksGridDataModel], showAsPurchased: Bool, onTap: ((SampleBundle) -> Void)? = nil) {
        self.models = models
        self.showAsPurchased = showAsPurchased
        self.onTap = onTap
    }
    init(_ bundles: [SampleBundle], showAsPurchased: Bool, onTap: ((SampleBundle) -> Void)? = nil) {
        self.models = BundlesGridDataModel(bundles).bundles
        self.showAsPurchased = showAsPurchased
        self.onTap = onTap
    }
    
    var body: some View {
        let bundleColumns = Array(repeating: GridItem(.flexible(), spacing: gridHSpacing, alignment: .center), count: 4)
        ScrollView {
            VStack {
                HStack {
                    Spacer(minLength: 20)
                    LazyVGrid(columns: bundleColumns, spacing: gridVSpacing) {
                        ForEach(models, id: \.self) { model in
                            ArtworksGrid(model, showAsPurchased: showAsPurchased)
                            .onTapGesture {
                                onTap?(SampleData.sampleBundle)
                            }
                        }
                    }
                    Spacer(minLength: 20)
                }
                .foregroundColor(.gray)
            }
            .padding(20)
        }
    }
}

struct BundlesGrid_Previews: PreviewProvider {
    static var previews: some View {
        BundlesGrid(SampleData.bundles, showAsPurchased: false)
            .preferredColorScheme(.dark)
    }
}
