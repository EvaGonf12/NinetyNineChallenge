import Foundation

struct Favourite {
    var name: String
    var hot: Int
    var ricCode: String
    var category: String
    
    init(apiResponse: FavouriteDetailsResponse) {
        self.name = apiResponse.name ?? ""
        self.hot = apiResponse.hot ?? 0
        self.ricCode = apiResponse.ricCode ?? ""
        self.category = apiResponse.category ?? ""
    }
}
