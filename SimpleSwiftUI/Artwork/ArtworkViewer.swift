import SwiftUI

struct ArtworkViewer: View {
    @ObservedObject var state: PuzzleState = PuzzleState()
    @State var overlayIsVisible: Bool = true
    let artwork: ArtworkViewModel
    var body: some View {
        ZStack {
            SampleViews.image(for: artwork.imageLargeName)            
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .padding(20)

            Overlay(artwork: artwork) {
                state.artworkID = artwork.id
                state.isPresented = true
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $state.isPresented, content: {
            VStack {
                PuzzlePlayer(state: state)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }

    struct Overlay: View {
        let artwork: ArtworkViewModel
        let onTap: (() -> Void)
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
                                
                                PlayButton() {
                                    onTap()
                                }
                            }
                            .padding(50)
                            
                        }
                        Toolbar() { target in
                            switch target {
                            case .tiling: break
                            }
                        }
                    }
                }
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .frame(maxWidth: 600)
            }
        }
    }

    struct PlayButton: View {
        let onTap: (() -> Void)
        var body: some View {
            ZStack {
                Image(systemName: "circle.fill")
                    .font( Font.system(size: 180))
                    .foregroundColor(.primary.opacity(0.5))
                Image(systemName: "circle.fill")
                    .font( Font.system(size: 140))
                    .foregroundColor(.primary.opacity(0.5))
                Button(action: {
                    onTap()
                }, label: {
                    Image(systemName: "play.fill")
                        .font( Font.system(size: 100))
                        .foregroundColor(.black)
                })
            }
        }
    }
    
    struct Toolbar: View {
        enum Target {case tiling}
        let onTap: ((Target) -> Void)
        var body: some View {
            HStack {
                Button(action: {
                    onTap(.tiling)
                }, label: {
                    Image(systemName: "hexagon")
                })
                Spacer()
            }
            .foregroundColor(Color.gray)
            .padding()
        }
    }
}

struct ArtworkViewer_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkViewer(artwork: ArtworkViewModel(SampleData.randomArtwork))
            .preferredColorScheme(.dark)
    }
}
