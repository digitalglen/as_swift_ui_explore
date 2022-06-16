import SwiftUI

struct ArtworkViewer: View {
    let artwork: SampleArtwork
    var body: some View {
        VStack {
            artwork.imageLarge
                .resizable()
                .aspectRatio(contentMode: .fit)
                .preferredColorScheme(.dark)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ArtworkViewer_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkViewer(artwork: SampleData.sampleArtwork)
            .preferredColorScheme(.dark)
    }
}
