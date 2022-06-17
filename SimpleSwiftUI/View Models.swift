import SwiftUI

class StoreState: ObservableObject {
    @Published var purchaseSheetStyle: PurchaseSheetStyleKind = .standard
    @Published var purchaseSheetIsVisible: Bool = false
    @Published var purchaseSheetBundle: SampleBundle = SampleData.bundle
}

class PuzzleState: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var artworkID: SampleArtwork.ID = SampleData.artwork.id
    var artwork: SampleArtwork {SampleData.artwork(forID: artworkID) ?? SampleData.artwork}
}
