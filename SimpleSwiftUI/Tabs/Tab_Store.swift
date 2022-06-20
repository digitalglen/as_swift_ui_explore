import SwiftUI

struct Tab_Store: View {
    @ObservedObject var state: StoreState = StoreState()
    @State private var displayStyle: BundlesBrowser.Style = .grid
    @State var searchQuery = ""
    
    var models: [ViewModel.Bundle] {
        if searchQuery.isEmpty {
            return ViewModel.samples.bundles
        }
        return ViewModel.samples.bundles.filter {$0.title.localizedCaseInsensitiveContains(searchQuery)}
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TopBar(displayStyle: displayStyle) { action in
                    switch action {
                    case .styleGrid:        displayStyle = .grid
                    case .styleCarousel:    displayStyle = .carousel
                    case .styleList:        displayStyle = .list
                    }
                }
                BundlesBrowser(models: models, showAsPurchased: false, style: displayStyle) { bundle in
                    state.purchaseSheetBundle = bundle
                    state.purchaseSheetIsVisible = true
                }
                PurchaseSheet(state: state, darkBehind: false)
            }
            .navigationTitle("Store")
        }
        .foregroundColor(.primary)
        .preferredColorScheme(.dark)
        .searchable(text: $searchQuery)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    struct TopBar: View {
        let displayStyle: BundlesBrowser.Style
        let onTap: ((Action) -> Void)
        enum Action {case styleGrid, styleCarousel, styleList}
        var body: some View {
            HStack {
                Spacer()
                ControlGroup {
                    Button(action: {
                        onTap(.styleCarousel)
                    }) {
                        Image(systemName: "rectangle.portrait")
                    }
                    Button(action: {
                        onTap(.styleList)
                    }) {
                        Image(systemName: "line.3.horizontal")
                    }
                    Button(action: {
                        onTap(.styleGrid)
                    }) {
                        Image(systemName: "circle.grid.3x3.fill")
                    }
                }
                .frame(maxWidth: 180)
            }
        }
    }
}

struct Tab_Store_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Store()
            .previewDisplayName("Store")
    }
}
