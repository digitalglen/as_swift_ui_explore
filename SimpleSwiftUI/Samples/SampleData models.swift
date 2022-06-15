import SwiftUI

struct SampleArtwork: Hashable {
    let title: String
    let artist: String
    let year: String
    let imageSquareName: String
    let imageLargeName: String
    var imageSquare: Image {
        if let image = UIImage(named: imageSquareName) {
            return Image(uiImage: image)
        } else {
            return Image("")
        }
    }
    var imageLarge: Image {
        if let image = UIImage(named: imageLargeName) {
            return Image(uiImage: image)
        } else {
            return Image("")
        }
    }
    
    init(jsonArtwork: SampleJson.JsonArtwork?) {
        self.title = jsonArtwork?.title ?? ""
        self.year = jsonArtwork?.year ?? ""
        self.artist = jsonArtwork?.artist ?? ""
        let imageLargeName = jsonArtwork?.uid ?? ""
        self.imageLargeName = imageLargeName + ".jpg"
        self.imageSquareName =  imageLargeName + "_sq.jpg"
    }
}

struct SampleBundle: Hashable {
    var title: String
    var price: String { "$1.99" }
    var artworks: [SampleArtwork]
}
