import SwiftUI

class StoreState: ObservableObject {
    @Published var purchaseSheetStyle: PurchaseSheetStyleKind = .standard
    @Published var purchaseSheetIsVisible: Bool = false
    @Published var purchaseSheetBundle: SampleBundle = SampleData.sampleBundle
}

class PuzzleState: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var artworkID: SampleArtwork.ID = SampleData.sampleArtwork.id
    var artwork: SampleArtwork {SampleData.sampleArtwork(forID: artworkID) ?? SampleData.sampleArtwork}
}
