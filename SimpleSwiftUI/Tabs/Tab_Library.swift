import SwiftUI

struct Tab_Library: View {
    let models = ViewModel.samples.bundles
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    BundlesBrowser(models: models, showAsPurchased: true)
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
    }
}
