import SwiftUI

struct Tab_Library: View {
    var body: some View {
        ZStack {
            ScrollView {
                Text("Library")
                    .font(.largeTitle)
                BundlesGrid(SampleData.purchasedBundles, showAsPurchased: true)
                .padding(4)
            }
        }
    }
}


struct Tab_Library_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Library()
            .previewDisplayName("Library")
            .preferredColorScheme(.dark)
    }
}
