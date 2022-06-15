import SwiftUI

struct ArtworkDataModel: Hashable {
    let title: String
    let imageName: String
    var image: Image? {
        guard let imageData = UIImage(named: imageName) else {return nil}
        return Image(uiImage: imageData)
    }
    
    init(title: String, price: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    init(_ artwork: SampleArtwork) {
        self.title = artwork.title
        self.imageName = artwork.imageSquareName
    }
}

struct ArtworksGridDataModel: Hashable {
    let title: String
    let price: String
    let artworks: [ArtworkDataModel]

    init(title: String, price: String, artworks: [ArtworkDataModel] = []) {
        self.title = title
        self.price = price
        self.artworks = artworks
    }
    init(_ bundle: SampleBundle) {
        self.title = bundle.title
        self.price = bundle.price
        self.artworks = bundle.artworks.map {ArtworkDataModel($0)}
    }
}


struct BundlesGridDataModel: Hashable {
    let bundles: [ArtworksGridDataModel]

    init(bundles: [ArtworksGridDataModel] = []) {
        self.bundles = bundles
    }
    init(_ bundles: [SampleBundle]) {
        self.bundles = bundles.map {ArtworksGridDataModel($0)}
    }
}
