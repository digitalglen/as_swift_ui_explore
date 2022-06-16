import SwiftUI

struct ArtworkViewer: View {
    @ObservedObject var state: PuzzleState = PuzzleState()
    let artwork: SampleArtwork
    var body: some View {
        ZStack {
            artwork.imageLarge
                .resizable()
                .aspectRatio(contentMode: .fit)

            VStack {
                Spacer()
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
                    
                    Spacer()
                    PlayButton()
                }
                .padding(50)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .fixedSize()
                
                Spacer(minLength: 10)
                
                VStack {
                    HStack(alignment: .center) {
                        Text("TBD")
                            .foregroundColor(.black)
                        Text("progress")
                        Text("tiling")
                        Text("difficulty")
                    }
                    .font(.body)
                    .foregroundColor(.secondary)
                }
                .padding(20)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .fixedSize()
                Spacer()
            }
            .fixedSize()
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
    
    struct PlayButton: View {
        var body: some View {
            ZStack {
                Image(systemName: "circle.fill")
                    .font( Font.system(size: 180))
                    .foregroundColor(.primary.opacity(0.5))
                Image(systemName: "circle.fill")
                    .font( Font.system(size: 140))
                    .foregroundColor(.primary.opacity(0.5))
                Button(action: {
                }, label: {
                    Image(systemName: "play.fill")
                        .font( Font.system(size: 100))
                        .foregroundColor(.black)
                })
            }
        }
    }
}

struct ArtworkViewer_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkViewer(artwork: SampleData.sampleArtwork)
            .preferredColorScheme(.dark)
    }
}
