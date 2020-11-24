import Foundation

struct FavouriteDetailsRequest: APIRequest {
    
    typealias Response = FavouriteDetailsResponse
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/favorites/\(self.id)"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
