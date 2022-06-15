import SwiftUI

struct BundleViewer: View {
    let bundle: SampleBundle
    var body: some View {
        VStack {
                ArtworksGrid(ArtworksGridDataModel(bundle), showAsPurchased: true)
        }
        .navigationBarTitle(bundle.title)
    }
}

struct BundleViewer_Previews: PreviewProvider {
    static var previews: some View {
        BundleViewer(bundle: SampleData.sampleBundle)
            .preferredColorScheme(.dark)
    }
}
