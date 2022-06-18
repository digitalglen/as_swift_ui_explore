import SwiftUI
import WeatherKit
import MapKit

struct PuzzlePlayer: View {
    @ObservedObject var state: PuzzleState
    @State var overlayIsVisible: Bool = true
    let model: ViewModel.Artwork
    
    var body: some View {
        ZStack {
            SampleViews.image(for: model.imageLargeName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(20)
                .padding(20)

            Overlay(model: model) { target in
                state.artworkID = model.id
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
        let model: ViewModel.Artwork
        let onTap: ((Target) -> Void)
        var body: some View {
            HStack(alignment: .center) {
                VStack {
                    ZStack(alignment: .bottom) {
                        VStack {
                            VStack(spacing: 8) {
                                Text("\(model.title)")
                                    .font(.largeTitle)
                                    .foregroundColor(.primary)
                                Text("\(model.artist)")
                                    .font(.title)
                                    .foregroundColor(.secondary)
                                Text("\(model.year)")
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
        PuzzlePlayer(state: PuzzleState(), model: ViewModel.samples.randomArtwork)
            .preferredColorScheme(.dark)
    }
}
