import SwiftUI

struct Tab_Library: View {
    @ObservedObject var state: StoreState = StoreState()
    var bundles: [Int] {[1, 2, 3, 4, 5, 6, 7, 8]}
    var body: some View {
        ZStack {
            ScrollView {
                Text("Library")
                    .font(.largeTitle)
                GridOfBundles(state: state, bundles: SampleData.purchasedBundles, showAsPurchased: true)
                .padding(4)
            }            
            PurchaseSheet(state: state)
            
        }
    }
}


struct Tab_Library_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Library()
            .previewDisplayName("Library")
            .preferredColorScheme(.dark)
    }
}
