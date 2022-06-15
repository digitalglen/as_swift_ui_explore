import SwiftUI

struct Tab_Today: View {
    var body: some View {
        VStack {
            Today()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.primary)
        .preferredColorScheme(.dark)
    }
}

struct Tab_Today_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Today()
            .previewDisplayName("Today")
            .preferredColorScheme(.dark)
    }
}
