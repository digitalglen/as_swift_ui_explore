import SwiftUI

struct BundleViewerGrid: View {
    let model: ViewModel.Bundle
    
    let cellSpacing: Double = 2
    var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: cellSpacing, alignment: .center), count: 3) }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: cellSpacing) {
                ForEach(model.artworks, id: \.self) { model in
                    ZStack(alignment: .top) {
                        NavigationLink(destination: ArtworkViewer(model: model)) {
                            SampleViews.image(for: model.imageSquareName)
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
        let model = ViewModel.samples.bundle
        BundleViewerGrid(model: model)
            .padding([.all], 20)
            .preferredColorScheme(.dark)
    }
}
