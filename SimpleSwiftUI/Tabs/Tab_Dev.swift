import SwiftUI

struct Tab_Dev: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink("Purchase Sheets", destination: Dev_PurchaseSheets())
                }
                .foregroundColor(.primary)
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
