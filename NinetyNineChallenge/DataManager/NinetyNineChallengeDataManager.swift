import Foundation

class NinetyNineChallengeDataManager {
    let localDataManager: NinetyNineChallengeLocalDataManager
    let remoteDataManager: NinetyNineChallengeRemoteDataManager

    init(localDataManager: NinetyNineChallengeLocalDataManager, remoteDataManager: NinetyNineChallengeRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

extension NinetyNineChallengeDataManager: FavouritesDataManager {
    func fetchAllFavourites(completion: @escaping (Result<ListFavouritesResponse, Error>) -> ()) {
        self.remoteDataManager.fetchFavourites(completion: completion)
    }
}

extension NinetyNineChallengeDataManager: FavouriteDetailsDataManager {
    func fetchFavourite(id: String, completion: @escaping (Result<FavouriteDetailsResponse, Error>) -> ()) {
        self.remoteDataManager.fetchFavourite(id: id, completion: completion)
    }   
}
