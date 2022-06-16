import SwiftUI

struct ArtworkViewModel: Hashable, Identifiable {
    typealias ID = String
    let id: ID
    let title: String
    let imageName: String
    var image: Image? {
        guard let imageData = UIImage(named: imageName) else {return nil}
        return Image(uiImage: imageData)
    }
    
    init(id: String, title: String, price: String, imageName: String) {
        self.id = id
        self.title = title
        self.imageName = imageName
    }
    init(_ artwork: SampleArtwork) {
        self.id = artwork.id
        self.title = artwork.title
        self.imageName = artwork.imageSquareName
    }
}


struct BundlesGridViewModel: Hashable {
    let bundles: [BundlesGridItemViewModel]

    init(bundles: [BundlesGridItemViewModel] = []) {
        self.bundles = bundles
    }
    init(_ bundles: [SampleBundle]) {
        self.bundles = bundles.map {BundlesGridItemViewModel($0)}
    }
}

struct BundlesGridItemViewModel: Hashable, Identifiable {
    typealias ID = String
    let id: ID
    let title: String
    let price: String
    let artworks: [ArtworkViewModel]

    init(id: String, title: String, price: String, artworks: [ArtworkViewModel] = []) {
        self.id = id
        self.title = title
        self.price = price
        self.artworks = artworks
    }
    init(_ bundle: SampleBundle) {
        self.id = bundle.id
        self.title = bundle.title
        self.price = bundle.price
        self.artworks = bundle.artworks.map {ArtworkViewModel($0)}
    }
}
