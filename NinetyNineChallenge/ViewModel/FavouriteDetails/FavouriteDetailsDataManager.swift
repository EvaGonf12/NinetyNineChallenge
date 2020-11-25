import Foundation
import RxSwift

protocol FavouriteDetailsDataManager {
    func fetchFavourite(id: String) -> Observable<FavouriteDetailsResponse>
}
