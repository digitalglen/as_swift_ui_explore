import SwiftUI

struct ContentView: View {
    var body: some View {
        Tabs()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Art Scrambles")
            .preferredColorScheme(.dark)
    }
}
