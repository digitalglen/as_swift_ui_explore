import SwiftUI

struct Tab_Library: View {
    let bundles = BundlesGridViewModel(SampleData.purchasedBundles).bundles
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    BundlesGrid(models: bundles, showAsPurchased: true)
                }
            }
            .navigationTitle("Library")
        }
        .preferredColorScheme(.dark)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct Tab_Library_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Library()
            .previewDisplayName("Library")
            .preferredColorScheme(.dark)
    }
}
