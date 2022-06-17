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
        .ignoresSafeArea()
    }
}

struct PuzzlePlayer_Previews: PreviewProvider {
    static var previews: some View {
        PuzzlePlayer(state: PuzzleState())
    }
}
