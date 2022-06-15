import SwiftUI

struct Tab_Store: View {
    @ObservedObject var state: StoreState = StoreState()
    var body: some View {
        VStack {
            Text("Store")
                .font(.largeTitle)
            ScrollView {
                BundlesGrid(SampleData.bundles, showAsPurchased: false) { bundle in
                    withAnimation {
                        state.purchaseSheetBundle = bundle
                        state.purchaseSheetIsVisible = true
                    }
                }
                .padding(4)
            }
            PurchaseSheet(state: state)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .preferredColorScheme(.dark)
    }
}

struct Tab_Store_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Store()
            .previewDisplayName("Store")
            .preferredColorScheme(.dark)
    }
}
