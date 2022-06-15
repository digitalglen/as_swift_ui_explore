import SwiftUI

class StoreState: ObservableObject {
    @Published var purchaseSheetStyle: PurchaseSheetStyleKind = .standard
    @Published var purchaseSheetIsVisible: Bool = false
    @Published var purchaseSheetBundle: SampleBundle = SampleData.sampleBundle
}
