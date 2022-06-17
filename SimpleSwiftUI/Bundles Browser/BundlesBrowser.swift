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
        let bundles = Array(SampleData.bundles[0...4])
        let models = bundles.map {ViewModel.Bundle($0)}
        BundlesBrowser(models: models, showAsPurchased: false)
            .preferredColorScheme(.dark)
    }
}
