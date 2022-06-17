import SwiftUI
import WeatherKit
import MapKit

struct PuzzlePlayer: View {
    @ObservedObject var state: PuzzleState
    @State var overlayIsVisible: Bool = true
    let artwork: ViewModel.Artwork
    
    var body: some View {
        ZStack {
            SampleViews.image(for: artwork.imageLargeName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(20)
                .padding(20)

            Overlay(artwork: artwork) { target in
                state.artworkID = artwork.id
                state.isPresented = true
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            state.isPresented = false
        }
        .ignoresSafeArea()
    }
    
    struct Overlay: View {
        enum Target {case tiling}
        let artwork: ViewModel.Artwork
        let onTap: ((Target) -> Void)
        var body: some View {
            HStack(alignment: .center) {
                VStack {
                    ZStack(alignment: .bottom) {
                        VStack {
                            VStack(spacing: 8) {
                                Text("\(artwork.title)")
                                    .font(.largeTitle)
                                    .foregroundColor(.primary)
                                Text("\(artwork.artist)")
                                    .font(.title)
                                    .foregroundColor(.secondary)
                                Text("\(artwork.year)")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            .padding(50)
                        }
                        Toolbar() { target in
                            switch target {
                            case .tiling:
                                onTap(.tiling)
                            }
                        }
//                        .background(.orange)
                    }
                }
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .frame(maxWidth: 600)
            }
        }
    }
    
    struct Toolbar: View {
        enum Target {case tiling}
        let onTap: ((Target) -> Void)
        var body: some View {
            HStack {
//                Button(action: {
//                    onTap(.tiling)
//                }, label: {
//                    Image(systemName: "square.and.arrow.up")
//                })
                Spacer()
            }
            .foregroundColor(Color.primary)
            .padding()
        }
    }
}

struct PuzzlePlayer_Previews: PreviewProvider {
    static var previews: some View {
        PuzzlePlayer(state: PuzzleState(), artwork: ViewModel.Artwork(SampleData.randomArtwork))
            .preferredColorScheme(.dark)
    }
}
