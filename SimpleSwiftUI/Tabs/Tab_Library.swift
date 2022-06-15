import SwiftUI

struct Tab_Library: View {
    @State private var goToBundle: Bool = false
    @State private var bundle: SampleBundle = SampleData.sampleBundle
    var tappedBundle: SampleBundle {bundle}
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    BundlesGrid(SampleData.purchasedBundles, showAsPurchased: true) { bundle in
                        self.bundle = bundle
                        self.goToBundle.toggle()
                    }
                    .padding(4)
                }
                NavigationLink(destination: BundleViewer(bundle: tappedBundle), isActive: $goToBundle) { EmptyView() }
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
