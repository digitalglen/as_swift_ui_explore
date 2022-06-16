import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func squared() -> some View {
        modifier(SquareViewModifier())
    }
    
    func fullscreen() -> some View {
      modifier(Fullscreen())
    }
}

// ---------------------------------------------

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct SquareViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .aspectRatio(1.0, contentMode: .fill)
  }
}

struct Fullscreen: ViewModifier {
    func body(content: Content) -> some View {
        content
            .statusBar(hidden: true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
    }
}
