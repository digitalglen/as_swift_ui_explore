import SwiftUI

struct PuzzlePlayer: View {
    @ObservedObject var state: PuzzleState
    var body: some View {
        VStack {
            state.artwork.imageLarge
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .onTapGesture {
            state.isPresented = false
        }
//        .fullscreen()
    }
}

struct PuzzlePlayer_Previews: PreviewProvider {
    static var previews: some View {
        PuzzlePlayer(state: PuzzleState())
    }
}
