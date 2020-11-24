import Foundation

enum FavouritesDataManagerError: Error {
    case unknown
}

protocol FavouritesDataManager {
    func fetchAllFavourites(completion: @escaping (Result<ListFavouritesResponse, Error>) -> ())
}

