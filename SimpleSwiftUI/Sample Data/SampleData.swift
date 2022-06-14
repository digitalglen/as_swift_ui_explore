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
    var artworks: [SampleArtwork]
}

struct SampleData {
    static var sampleBundleFileNames: [String] {[
        "collection_alma_tadema",
        "collection_angelico_1",
        "collection_angelico_2",
        "collection_art_nouveau_posters",
        "collection_bierstadt",
        "collection_bosch",
        "collection_bosch_haywain",
        "collection_bouguereau_1",
        "collection_bouguereau_2",
        "collection_brueghel",
        "collection_brueghel_games",
        "collection_brueghel_proverbs",
        "collection_masterpieces_1",
        "collection_masterpieces_2",
        "collection_masterpieces_3",
        "collection_masterpieces_4",
        "collection_masterpieces_5",
        "collection_masterpieces_6",
        "collection_loc_1",
        "collection_loc_2",
        "collection_loc_3",
    ]}

    static var sampleBundles: [SampleBundle] {
        sampleBundleFileNames.map {sampleBundle(filename: $0)}
    }

    static var sampleBundle: SampleBundle {
        sampleBundles.last!
    }

    static func sampleBundle(filename: String) -> SampleBundle {
        if let jsonBundle = SampleJson().loadJson(filename: filename), let jsonArtworks = jsonBundle.artworks {
            let artworks = jsonArtworks.map {SampleArtwork(jsonArtwork: $0)}
//            print(artworks)
            return SampleBundle(title: jsonBundle.title, artworks: artworks)
        } else {
            return SampleBundle(title: "Invalid Bundle", artworks: [])
        }
    }
    
    static var calculatedPurchasedBundles: [SampleBundle]? = nil
    static var purchasedBundles: [SampleBundle] {
        if let calculated = calculatedPurchasedBundles {return calculated}
        var randoms = Set<SampleBundle>()
        for _ in 0...1000 {
            if let random = sampleBundles.randomElement() {
                randoms.insert(random)
            }
            if randoms.count >= 5 {
                break
            }
        }
        let array = Array(randoms).sorted { one, two in
            one.title < two.title
        }
        calculatedPurchasedBundles = array
        return array
    }

    static var bundles: [SampleBundle] {
        sampleBundles.sorted { one, two in
            one.title < two.title
        }
    }
}
