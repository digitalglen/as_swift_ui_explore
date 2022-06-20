import SwiftUI

struct BundlesBrowser: View {
    enum Style {case grid, carousel, list}
    let models: [ViewModel.Bundle]
    let showAsPurchased: Bool
    var style: Style = .carousel
    var onTap: ((_ bundle: SampleBundle) -> Void)? = nil

    var body: some View {
        switch style {
        case .grid:
            BundlesBrowser_Grid(models: models, showAsPurchased: showAsPurchased, onTap: onTap)
        case .carousel:
            BundlesBrowser_Carousel(models: models, showAsPurchased: showAsPurchased, onTap: onTap)
        case .list:
            BundlesBrowser_List(models: models, showAsPurchased: showAsPurchased, onTap: onTap)
        }
    }
}

struct BundlesBrowser_Previews: PreviewProvider {
    static var previews: some View {
        let models = Array(ViewModel.samples.bundles[0...4])
        BundlesBrowser(models: models, showAsPurchased: false)
            .preferredColorScheme(.dark)
    }
}
