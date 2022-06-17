import SwiftUI

struct BundlesBrowser: View {
    let models: [ViewModel.Bundle]
    let showAsPurchased: Bool
    var onTap: ((_ bundle: SampleBundle) -> Void)? = nil

    var body: some View {
        BundlesBrowser_Grid(models: models, showAsPurchased: showAsPurchased, onTap: onTap)
    }
}

struct BundlesBrowser_Previews: PreviewProvider {
    static var previews: some View {
        let models = Array(ViewModel.samples.bundles[0...4])
        BundlesBrowser(models: models, showAsPurchased: false)
            .preferredColorScheme(.dark)
    }
}
