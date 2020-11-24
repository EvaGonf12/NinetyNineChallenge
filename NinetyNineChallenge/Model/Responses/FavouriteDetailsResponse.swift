import Foundation

struct FavouriteDetailsResponse: Codable {
    var name: String?
    var hot: Int?
    var ricCode: String?
    var category: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case hot
        case ricCode
        case category
    }
}
