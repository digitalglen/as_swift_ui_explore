import SwiftUI


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

protocol BrowsableItem {
    var view: any View {get}
}

protocol Browsable {
    associatedtype Item
    var items: [Item] {get}
    func view(for: Item) -> any View
}
