import SwiftUI

struct BundleViewerGrid: View {
    let model: ArtworksGridViewModel
    let showAsPurchased: Bool
    let onTap: ((_ artworkID: SampleArtwork.ID) -> Void)?
    
    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(model.artworks, id: \.self) { model in
                    ZStack(alignment: .top) {
                        SampleViews.image(for: model.imageName)
                            .squared()
                            .onTapGesture {
                                onTap?(model.id)
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
        let model = ArtworksGridViewModel(SampleData.sampleBundle)
        BundleViewerGrid(model: model, showAsPurchased: false, onTap: nil)
            .padding([.all], 20)
            .preferredColorScheme(.dark)
    }
}
