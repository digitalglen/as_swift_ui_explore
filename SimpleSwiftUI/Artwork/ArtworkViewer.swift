import SwiftUI

struct ArtworkViewer: View {
    let artwork: SampleArtwork
    var body: some View {
        artwork.imageLarge
            .aspectRatio(contentMode: .fit)
            .preferredColorScheme(.dark)
    }
}

struct ArtworkViewer_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkViewer(artwork: SampleData.sampleArtwork)
            .preferredColorScheme(.dark)
    }
}
