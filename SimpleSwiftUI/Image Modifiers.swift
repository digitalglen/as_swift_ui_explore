import SwiftUI


extension Image {
    func squared() -> some View {
        self
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
    }
}
