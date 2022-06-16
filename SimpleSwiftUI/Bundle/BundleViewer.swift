import SwiftUI

struct BundleViewer: View {
    let bundle: SampleBundle
    @State private var goToArtworkViewer: Bool = false
    @State private var artwork: SampleArtwork? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            BundleViewerGrid(model: BundlesGridItemViewModel(bundle), showAsPurchased: true) { artworkID in
                self.artwork = SampleData.sampleArtwork(id: artworkID)
                self.goToArtworkViewer.toggle()
            }

            if goToArtworkViewer {
                NavigationLink(destination: NavigationLazyView(ArtworkViewer(artwork: artwork!))) { Text("") }
            }
        }
        .navigationBarTitle(bundle.title)
    }
}

struct BundleViewer_Previews: PreviewProvider {
    static var previews: some View {
        BundleViewer(bundle: SampleData.sampleBundle)
            .preferredColorScheme(.dark)
    }
}
