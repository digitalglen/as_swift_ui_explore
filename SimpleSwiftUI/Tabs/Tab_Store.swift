import SwiftUI

struct Tab_Store: View {
    @ObservedObject var state: StoreState = StoreState()
    @State private var displayStyle: BundlesBrowser.Style = .grid
    let models = ViewModel.samples.bundles
    var body: some View {
        NavigationView {
            VStack {
                TopBar(displayStyle: displayStyle) { action in
                    switch action {
                    case .style: toggleDisplayStyle()
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func toggleDisplayStyle() {
        withAnimation {
            switch displayStyle {
            case .grid:         displayStyle = .carousel
            case .carousel:     displayStyle = .grid
            }
        }
    }
    
    struct TopBar: View {
        let displayStyle: BundlesBrowser.Style
        let onTap: ((Action) -> Void)
        enum Action {case style}
        var body: some View {
            HStack {
                Spacer()
                Button(action: {
                    onTap(.style)
                }) {
                    switch displayStyle {
                    case .grid:         Label("Detail", systemImage: "rectangle.portrait")
                    case .carousel:     Label("Grid", systemImage: "circle.grid.3x3.fill")
                    }
                }
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
