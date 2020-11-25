import Foundation
import RxSwift

class NinetyNineChallengeDataManager {
    let localDataManager: NinetyNineChallengeLocalDataManager
    let remoteDataManager: NinetyNineChallengeRemoteDataManager

    init(localDataManager: NinetyNineChallengeLocalDataManager, remoteDataManager: NinetyNineChallengeRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

extension NinetyNineChallengeDataManager: FavouritesDataManager {
    func fetchFavourites() -> (Observable<[String]>) {
        return self.remoteDataManager.fetchFavourites()
    }
}

extension NinetyNineChallengeDataManager: FavouriteDetailsDataManager {
    func fetchFavourite(id: String) -> Observable<FavouriteDetailsResponse> {
        return self.remoteDataManager.fetchFavourite(id: id)
    }
}
