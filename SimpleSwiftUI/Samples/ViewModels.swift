import SwiftUI

struct ViewModel {
    struct samples {
        static var bundle: ViewModel.Bundle {
            bundles.last!
        }
        static var bundles: [ViewModel.Bundle] {
            SampleData.bundles.map { ViewModel.Bundle($0) }
        }
        static var purchasedBundles: [ViewModel.Bundle] {
            SampleData.purchasedBundles.map { ViewModel.Bundle($0) }
        }
    }
    struct Artwork: Hashable, Identifiable {
        typealias ID = String
        let id: ID
        let title: String
        let artist: String
        let year: String
        let imageLargeName: String
        var uiImageLarge: UIImage? {
            UIImage(named: imageLargeName)
        }
        var imageLarge: Image? {
            guard let imageData = uiImageLarge else {return nil}
            return Image(uiImage: imageData)
        }
        let imageSquareName: String
        var uiImageSquare: UIImage? {
            UIImage(named: imageSquareName)
        }
        var imageSquare: Image? {
            guard let imageData = uiImageSquare else {return nil}
            return Image(uiImage: imageData)
        }
        
        init(id: String, title: String, artist: String, year: String, imageLargeName: String, imageSquareName: String) {
            self.id = id
            self.title = title
            self.artist = artist
            self.year = year
            self.imageLargeName = imageLargeName
            self.imageSquareName = imageSquareName
        }
        init(_ artwork: SampleArtwork) {
            self.id = artwork.id
            self.title = artwork.title
            self.artist = artwork.artist
            self.year = artwork.year
            self.imageLargeName = artwork.imageLargeName
            self.imageSquareName = artwork.imageSquareName
        }
    }
    
    struct Bundle: Hashable, Identifiable {
        typealias ID = String
        let id: ID
        let title: String
        let price: String
        let artworks: [Artwork]
        
        init(id: String, title: String, price: String, artworks: [Artwork] = []) {
            self.id = id
            self.title = title
            self.price = price
            self.artworks = artworks
        }
        init(_ bundle: SampleBundle) {
            self.id = bundle.id
            self.title = bundle.title
            self.price = bundle.price
            self.artworks = bundle.artworks.map {Artwork($0)}
        }
    }
}
