import SwiftUI

struct BundleViewer: View {
    let bundle: SampleBundle
    @State private var goToArtworkViewer: Bool = false
    @State private var artwork: SampleArtwork?
    var tappedArtwork: SampleArtwork {artwork!}
    
    var body: some View {
        ZStack(alignment: .top) {
            BundleViewerGrid(model: ArtworksGridViewModel(bundle), showAsPurchased: true) { artwork in
                self.artwork = artwork
                self.goToArtworkViewer.toggle()
            }

            if goToArtworkViewer {
                NavigationLink(destination: ArtworkViewer(artwork: tappedArtwork), isActive: $goToArtworkViewer) { EmptyView() }
            }
            VStack {
//                Text("")
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 150)
//                    .background(Material.bar)
            }
        }
        .navigationBarTitle(bundle.title)
        .background(Color.clear.ignoresSafeArea(.all, edges: [.bottom]))
//        .fullscreen()
    }
}

struct BundleViewer_Previews: PreviewProvider {
    static var previews: some View {
        BundleViewer(bundle: SampleData.sampleBundle)
            .preferredColorScheme(.dark)
    }
}
