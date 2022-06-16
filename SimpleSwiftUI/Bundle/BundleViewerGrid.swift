import SwiftUI

struct BundleViewerGrid: View {
    let model: BundlesGridItemViewModel
    let showAsPurchased: Bool
    
    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(model.artworks, id: \.self) { model in
                    ZStack(alignment: .top) {
                        NavigationLink(destination: ArtworkViewer(artwork: SampleData.sampleArtwork(forID: model.id)!)) {
                            SampleViews.image(for: model.imageName)
                                .squared()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .font( .body)
        }
    }
}

struct BundleViewerGrid_Previews: PreviewProvider {
    static var previews: some View {
        let model = BundlesGridItemViewModel(SampleData.sampleBundle)
        BundleViewerGrid(model: model, showAsPurchased: false)
            .padding([.all], 20)
            .preferredColorScheme(.dark)
    }
}
