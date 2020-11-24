import Foundation

struct ListFavouritesResponse: Codable {
    var result : [String]
    
    enum CodingKeys: String, CodingKey {
        case result
    }
}
