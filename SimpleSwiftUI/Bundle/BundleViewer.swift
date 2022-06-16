import SwiftUI

struct BundleViewer: View {
    let bundle: SampleBundle
    @State private var goToArtworkViewer: Bool = false
    @State private var artwork: SampleArtwork? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            BundleViewerGrid(model: ArtworksGridViewModel(bundle), showAsPurchased: true) { artworkID in
                self.artwork = SampleData.sampleArtwork(id: artworkID)
                self.goToArtworkViewer.toggle()
            }

            if goToArtworkViewer {
                navigationLink(for: artwork!)
            }
        }
        .navigationBarTitle(bundle.title)
    }
    
    func navigationLink(for artwork: SampleArtwork) -> some View {
        NavigationLink(destination: ArtworkViewer(artwork: artwork), isActive: .constant(true)) { EmptyView() }
    }
}

struct BundleViewer_Previews: PreviewProvider {
    static var previews: some View {
        BundleViewer(bundle: SampleData.sampleBundle)
            .preferredColorScheme(.dark)
    }
}
