import SwiftUI

class StoreState: ObservableObject {
    @Published var purchaseSheetStyle: PurchaseSheetStyleKind = .hero10
    @Published var purchaseSheetIsVisible: Bool = false
    @Published var purchaseSheetBundle: SampleBundle = SampleData.sampleBundle
}
