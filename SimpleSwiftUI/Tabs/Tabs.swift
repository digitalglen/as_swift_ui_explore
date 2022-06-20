import SwiftUI

enum Tab: Int {
    case today = 0
    case store = 1
    case library = 2
    case settings = 3
    case dev = 4
}

struct Tabs: View {
    @SceneStorage("selectedTab")
    private var selectedTab: Int = Tab.today.rawValue
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab_Today()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                    Text("Today")
                }
                .tag(Tab.today.rawValue)
            Tab_Store()
                .tabItem {
                    Label("Store", systemImage: "square.grid.2x2")
                    Text("Store")
                }
                .tag(Tab.store.rawValue)
            Tab_Library()
                .tabItem {
                    Label("Library", systemImage: "person")
                    Text("Library")
                }
                .tag(Tab.library.rawValue)
            Tab_Settings()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                    Text("Settings")
                }
                .tag(Tab.settings.rawValue)
            Tab_Dev()
                .tabItem {
                    Label("Dev", systemImage: "wrench")
                    Text("Dev")
                }
                .tag(Tab.dev.rawValue)
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
