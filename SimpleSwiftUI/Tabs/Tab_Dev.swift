import SwiftUI

struct Tab_Dev: View {
    @ObservedObject var state: StoreState = StoreState()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink("Purchase Sheets", destination: Dev_PurchaseSheets())
                }
                .foregroundColor(.white)
                .navigationTitle("Development")
            }
        }
        .preferredColorScheme(.dark)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct Tab_Dev_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Dev()
            .previewDisplayName("Dev")
    }
}
