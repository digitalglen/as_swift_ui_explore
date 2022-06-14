import SwiftUI

class StoreState: ObservableObject {
    @Published var purchaseSheetStyle: PurchaseSheetStyleKind = .hero10
    @Published var purchaseSheetIsVisible: Bool = false
    @Published var purchaseSheetBundle: SampleBundle = SampleData.sampleBundle
}

struct Tab_Store: View {
    @ObservedObject var state: StoreState = StoreState()
    var body: some View {
        VStack {
            Text("Store")
                .font(.largeTitle)
            StoreGrid(state: state, showAsPurchased: false)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .preferredColorScheme(.dark)
    }
}

private struct StoreGrid: View {
    @ObservedObject var state: StoreState
    let showAsPurchased: Bool
    var body: some View {
        ZStack {
            ScrollView {
                GridOfBundles(state: state, bundles: SampleData.bundles, showAsPurchased: showAsPurchased)
                .padding(4)
            }
            PurchaseSheet(state: state)
        }
    }
}

struct Tab_Store_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Store()
            .previewDisplayName("Store")
            .preferredColorScheme(.dark)
    }
}
