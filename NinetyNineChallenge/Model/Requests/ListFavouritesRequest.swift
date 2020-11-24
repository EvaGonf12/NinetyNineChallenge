import Foundation

struct ListFavouritesRequest: APIRequest {
    
    typealias Response = ListFavouritesResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/favorites"
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
