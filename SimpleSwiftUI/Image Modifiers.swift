import SwiftUI


extension Image {
    func square() -> some View {
        self
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
    }
}
