import Foundation

protocol FavouriteDetailsDataManager {
    func fetchFavourite(id: String, completion: @escaping (Result<FavouriteDetailsResponse, Error>) -> ())
}
