import SwiftUI

struct Tab_Store: View {
    @ObservedObject var state: StoreState = StoreState()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        BundlesGrid(models: BundlesGridViewModel(SampleData.bundles).bundles,
                                    showAsPurchased: false) { bundle in
                            withAnimation {
                                state.purchaseSheetBundle = bundle
                                state.purchaseSheetIsVisible = true
                            }
                        }
                        .padding(4)
                    }
                }
                PurchaseSheet(state: state)
            }
            .navigationTitle("Store")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.primary)
        .preferredColorScheme(.dark)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Tab_Store_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Store()
            .previewDisplayName("Store")
            .preferredColorScheme(.dark)
    }
}
