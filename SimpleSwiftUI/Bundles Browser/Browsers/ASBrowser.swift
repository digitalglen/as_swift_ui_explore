import SwiftUI

struct BundleBrowser: View, Browsable  {
    typealias Source = BundleBrowsable
    var onTap: ((_ item: Source.Item) -> Void)? = nil
    var source: some BrowsableSource {
        BundleBrowsable(SampleData.bundles)
    }
    var body: some View {
        BrowserContent().itemContent(source)
    }
}

struct BrowserContent  {
    @MainActor
    func itemContent(_ source: some BrowsableSource) -> some View {
        ForEach(source.items) {item in
            NavigationLink(destination: item.destination()) {
                item.body()
            }
        }
    }
}
