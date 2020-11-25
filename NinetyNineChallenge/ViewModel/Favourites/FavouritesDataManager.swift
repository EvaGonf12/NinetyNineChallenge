import Foundation
import RxSwift

enum FavouritesDataManagerError: Error {
    case unknown
}

protocol FavouritesDataManager {
    func fetchFavourites() -> (Observable<[String]>)
}

