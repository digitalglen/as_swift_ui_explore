import SwiftUI

struct BundleViewer: View {
    let bundle: SampleBundle
    var model: BundlesGridItemViewModel {BundlesGridItemViewModel(bundle)}
    
    var body: some View {
        ZStack(alignment: .top) {
            BundleViewerGrid(model: model, showAsPurchased: true)
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
