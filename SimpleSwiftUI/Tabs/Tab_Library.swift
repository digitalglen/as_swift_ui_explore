import SwiftUI

struct Tab_Library: View {
    @State private var displayStyle: BundlesBrowser.Style = .grid
    @State var searchQuery = ""

    var models: [ViewModel.Bundle] {
        let all = ViewModel.samples.purchasedBundles
        return searchQuery.isEmpty ? all : all.filter {$0.title.localizedCaseInsensitiveContains(searchQuery)}
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
                BundlesBrowser(models: models, showAsPurchased: true, style: displayStyle)
            }
            .navigationTitle("Library")
        }
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


struct Tab_Library_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Library()
            .previewDisplayName("Library")
    }
}
