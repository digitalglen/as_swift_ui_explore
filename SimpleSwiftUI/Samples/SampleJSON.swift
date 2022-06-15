import Foundation

struct SampleJson {
    struct JsonArtworkData: Decodable {
        var bundle: [JsonBundle]
        var artworks: [JsonArtwork]
    }
    struct JsonBundle: Decodable {
        var uid: String
        var productid: String
        var title: String
        var keywords: String
        var artworks: [JsonArtwork]?
    }
    struct JsonArtwork : Codable {
        var uid: String
        var artist: String
        var title: String

        var year: String?
        var format: String?
        var brightness_bottom_left: String?
        var brightness_bottom_center: String?
        var brightness_bottom_right: String?
        var brightness_thumb_bottom_right: String?
    }
    
    func loadJson(filename fileName: String) -> JsonBundle? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(JsonArtworkData.self, from: data)
                if var bundle = jsonData.bundle.first {
                    bundle.artworks = jsonData.artworks
                    return bundle
                }
                return nil
            } catch {
                print("error:\(error)")
                return nil
            }
        }
        return nil
    }
}
