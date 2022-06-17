import Foundation
import SwiftUI

struct ArtworkViewer: View {
    @ObservedObject var state: PuzzleState = PuzzleState()
    @State private var isSharePresented: Bool = false
    let artwork: ViewModel.Artwork
    var shareText: String {artwork.title}
    var shareImage: UIImage {artwork.uiImageLarge!}
    var shareURL: URL {Bundle.main.url(forResource: artwork.imageLargeName, withExtension: nil)!}
    var body: some View {
        ZStack {
            SampleViews.image(for: artwork.imageLargeName)            
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .padding(20)

            Overlay(artwork: artwork) { target in
                switch target {
                case .play:
                    state.artworkID = artwork.id
                    state.isPresented = true
                case .share:
                    isSharePresented = true
                }
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $state.isPresented, content: {
            VStack {
                PuzzlePlayer(state: state, artwork: artwork)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .sheet(isPresented: $isSharePresented, onDismiss: {
        }, content: {
            ActivityViewController(activityItems: [shareText, shareImage, shareURL])
        })
    }

    struct Overlay: View {
        enum Target {case play, share}
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
                                
                                PlayButton() {
                                    onTap(.play)
                                }
                            }
                            .padding(50)
                            
                        }
                        Toolbar() { target in
                            switch target {
                            case .tiling: break
                            case .share:
                                onTap(.share)
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
        enum Target {case tiling, share}
        let onTap: ((Target) -> Void)
        var body: some View {
            HStack {
                Button(action: {
                    onTap(.tiling)
                }, label: {
                    Image(systemName: "hexagon")
                })
                Spacer()
                Button(action: {
                    onTap(.share)
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
            .foregroundColor(.primary)
            .padding(20)
        }
    }
}

struct ArtworkViewer_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkViewer(artwork: ViewModel.Artwork(SampleData.randomArtwork))
            .preferredColorScheme(.dark)
    }
}
