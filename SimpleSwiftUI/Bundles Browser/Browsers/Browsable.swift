import SwiftUI


protocol Browsable {
    associatedtype Source: BrowsableSource where Source.Browser == Self
}

protocol BrowsableSource: Identifiable {
    associatedtype Browser: Browsable where Browser.Source == Self
    associatedtype Item: BrowsableItem where Item.Source == Self
    var items: [Item] {get}
    var onTap: ((_ item: Item) -> Void)? {get set}
}

protocol BrowsableItem: Identifiable {
    associatedtype Source: BrowsableSource where Source.Item == Self
    associatedtype Destination: View
    associatedtype Body: View
    @ViewBuilder @MainActor func destination() -> Destination
    @ViewBuilder @MainActor func body() -> Body
}

// -------------------------------------------------------------------------

struct BundleBrowsableItem: BrowsableItem {
    typealias Source = BundleBrowsable
    typealias Destination = BundleViewer
    typealias Body = BundlesBrowser_GridItem
    let bundle: SampleBundle
    var id: SampleBundle.ID {bundle.id}
    
    @MainActor
    func destination() -> Destination {
        BundleViewer(model: ViewModel.Bundle(bundle))
    }
    @MainActor
    func body() -> Body {
        BundlesBrowser_GridItem(model: ViewModel.Bundle(bundle), showAsPurchased: true)
    }
}

struct BundleBrowsable: BrowsableSource {
    typealias Browser = BundleBrowser
    typealias Item = BundleBrowsableItem
    let bundles: [SampleBundle]
    var id: String {"BundleBrowsable"}
    var items: [Item] {bundles.map {Item(bundle: $0)} }
    init(_ bundles: [SampleBundle]) {self.bundles = bundles}
    var onTap: ((_ item: Item) -> Void)? = nil
}


// -------------------------------------------------------------------------
/*
 protocol AnimalFeed {
   associatedtype CropType: Crop where CropType.Feed == Self
   static func grow() -> CropType
 }

 protocol Crop {
   associatedtype Feed: AnimalFeed where Feed.CropType == Self
   func harvest() -> Feed
 }

 protocol Animal {
   associatedtype Feed: AnimalFeed
   func eat(_ food: Feed)
 }

 struct Farm {
   func feed(_ animal: some Animal) {
     let crop = type(of: animal).Feed.grow()
     let produce = crop.harvest()
     animal.eat(produce)
   }

   func feedAll(_ animals: [any Animal]) {
     for animal in animals {
       feed(animal)
     }
   }
 }

 struct Cow: Animal {
   func eat(_ food: Hay) {}
 }

 struct Hay: AnimalFeed {
   static func grow() -> Alfalfa {
     Alfalfa()
   }
 }

 struct Alfalfa: Crop {
   func harvest() -> Hay {
     Hay()
   }
 }
*/
