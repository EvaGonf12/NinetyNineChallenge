import Foundation

struct ListFavouritesResponse: Codable {
    var listFavourites : [String]
    
    enum CodingKeys: String, CodingKey {
        case listFavourites = "result"
    }
}
