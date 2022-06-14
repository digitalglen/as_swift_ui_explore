import SwiftUI

enum PurchaseSheetStyleKind: String, Hashable, CaseIterable {
    case grid3x4, gridTopHero, hero10
    static let standard: PurchaseSheetStyleKind = .grid3x4
    var style: PurchaseSheetStyle {
        switch self {
        case .grid3x4: return PurchaseSheetStyle(title: "Grid", subtitle: "12", kind: self)
        case .gridTopHero: return PurchaseSheetStyle(title: "Grid + Hero", subtitle: "12", kind: self)
        case .hero10: return PurchaseSheetStyle(title: "Hero", subtitle: "10", kind: self)
        }
    }
}

struct PurchaseSheetStyle: Hashable {
    let title: String
    let subtitle: String
    let kind: PurchaseSheetStyleKind
}

protocol PurchaseSheetDesign {
    associatedtype Thumbnail : View
    var thumbnail: Thumbnail {get}
}
