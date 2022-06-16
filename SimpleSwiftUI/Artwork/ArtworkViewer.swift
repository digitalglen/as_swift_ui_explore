import SwiftUI

struct ArtworkViewer: View {
    @ObservedObject var state: PuzzleState = PuzzleState()
    let artwork: SampleArtwork
    var body: some View {
        VStack {
            artwork.imageLarge
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .onTapGesture {
            state.artwork = artwork
            state.isPresented = true
        }
        .fullScreenCover(isPresented: $state.isPresented, content: {
            VStack {
                PuzzlePlayer(state: state)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }
}

struct ArtworkViewer_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkViewer(artwork: SampleData.sampleArtwork)
            .preferredColorScheme(.dark)
    }
}
