import Foundation

protocol NinetyNineChallengeRemoteDataManager {
    func fetchFavourites(completion: @escaping (Result<ListFavouritesResponse, Error>) -> ())
    func fetchFavourite(id: String, completion: @escaping (Result<FavouriteDetailsResponse, Error>) -> ())
}
