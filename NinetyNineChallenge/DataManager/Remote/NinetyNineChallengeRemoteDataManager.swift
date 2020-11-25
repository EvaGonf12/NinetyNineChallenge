import Foundation
import RxSwift

protocol NinetyNineChallengeRemoteDataManager {
    func fetchFavourites() -> (Observable<[String]>)
    func fetchFavourite(id: String) -> (Observable<FavouriteDetailsResponse>)
}
