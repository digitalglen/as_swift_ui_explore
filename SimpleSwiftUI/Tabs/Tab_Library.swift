import SwiftUI

struct Tab_Library: View {
    @State private var displayStyle: BundlesBrowser.Style = .grid
    let models = ViewModel.samples.purchasedBundles
    var body: some View {
        NavigationView {
            VStack {
                    TopBar(displayStyle: displayStyle) { action in
                        switch action {
                        case .style:
                            switch displayStyle {
                            case .grid:         displayStyle = .carousel
                            case .carousel:     displayStyle = .grid
                            }
                        }
                    }
                BundlesBrowser(models: models, showAsPurchased: true, style: displayStyle)
            }
            .navigationTitle("Library")
        }
        .preferredColorScheme(.dark)
        .navigationViewStyle(StackNavigationViewStyle())
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


struct Tab_Library_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Library()
            .previewDisplayName("Library")
    }
}
