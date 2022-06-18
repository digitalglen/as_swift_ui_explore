import SwiftUI

enum Tab {
    case dev
    case today
    case store
    case library
    case settings
}

struct Tabs: View {
    @State private var tabSelection: Tab = .library
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Tab_Today()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                    Text("Today")
                }
                .tag(Tab.today)
            Tab_Store()
                .tabItem {
                    Label("Store", systemImage: "square.grid.2x2")
                    Text("Store")
                }
                .tag(Tab.store)
            Tab_Library()
                .tabItem {
                    Label("Library", systemImage: "person")
                    Text("Library")
                }
                .tag(Tab.library)
            Tab_Settings()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                    Text("Settings")
                }
                .tag(Tab.settings)
            Tab_Dev()
                .tabItem {
                    Label("Dev", systemImage: "wrench")
                    Text("Dev")
                }
                .tag(Tab.dev)
        }
        .accentColor( Color( UIColor.label ) )
        .preferredColorScheme(.dark)
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Tabs")
    }
}
