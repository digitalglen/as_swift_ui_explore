import SwiftUI

struct SampleData {
    private init() {}  // Everyone goes through the static class.
    
    static var cache: Cache = Cache()

    static var cachedBundles: [SampleBundle]? = nil
    static var sampleBundles: [SampleBundle] {
        if let fromCache = cache.bundles.all {return fromCache}
        cache.bundles.all = sampleBundleFileNames.map {sampleBundle(filename: $0)}
        return cache.bundles.all ?? []
    }

    private static var allImageNames: [String] {
        sampleBundles.reduce([]) { partialResult, bundle in
            partialResult + bundle.artworks.map {$0.imageSquareName}
        }
    }

    static func sampleImageNames(count: Int) -> [String] {
        allImageNames.dropLast(allImageNames.count - count)
    }
    
    static var sampleArtwork: SampleArtwork {
        sampleBundle.artworks.first!
    }
    
    static func sampleArtwork(forID id: SampleArtwork.ID) -> SampleArtwork? {
        var match: SampleArtwork? = nil
        sampleBundles.forEach {
            if let artwork = $0.artworks.filter({$0.id == id}).first {
                match = artwork
            }
        }
        return match
    }
    
    static var sampleBundle: SampleBundle {
        sampleBundles.last!
    }

    static func sampleBundle(filename: String) -> SampleBundle {
        if let jsonBundle = SampleJson().loadJson(filename: filename), let jsonArtworks = jsonBundle.artworks {
            let artworks = jsonArtworks.map {SampleArtwork(jsonArtwork: $0)}
//            print(artworks)
            return SampleBundle(id: jsonBundle.uid, title: jsonBundle.title, artworks: artworks)
        } else {
            return SampleBundle(id: UUID().uuidString, title: "Invalid Bundle", artworks: [])
        }
    }
        
    static func sampleBundle(forID id: SampleBundle.ID) -> SampleBundle? {
        sampleBundles.filter {$0.id == id}.first
    }
    
    static var purchasedBundles: [SampleBundle] {
        if let cached = cache.bundles.purchased {return cached}
        var randoms = Set<SampleBundle>()
        for _ in 0...1000 {
            if let random = sampleBundles.randomElement() {
                randoms.insert(random)
            }
            if randoms.count >= 5 {
                break
            }
        }
        cache.bundles.purchased = Array(randoms).sorted { $0.title < $1.title }
        return cache.bundles.purchased ?? []
    }

    static var bundles: [SampleBundle] {
        sampleBundles.sorted { one, two in
            one.title < two.title
        }
    }
}

extension SampleData {
    struct Cache {
        struct Bundles {
            var purchased: [SampleBundle]? = nil
            var all: [SampleBundle]? = nil
        }
        var bundles = Bundles()
    }
}

extension SampleData {
    static var sampleBundleFileNames: [String] {[
//        "collection_alma_tadema",
//        "collection_angelico_1",
//        "collection_angelico_2",
//        "collection_art_nouveau_posters",
//        "collection_bierstadt",
//        "collection_bosch",
//        "collection_bosch_haywain",
//        "collection_bouguereau_1",
//        "collection_bouguereau_2",
//        "collection_brueghel",
//        "collection_brueghel_games",
//        "collection_brueghel_proverbs",
        "collection_masterpieces_1",
        "collection_masterpieces_2",
        "collection_masterpieces_3",
        "collection_masterpieces_4",
        "collection_masterpieces_5",
        "collection_masterpieces_6",
//        "collection_loc_1",
//        "collection_loc_2",
//        "collection_loc_3",
    ]        
    }
    
}
