import Foundation
import RxSwift

final class NinetyNineChallengeRemoteDataManagerImp:  NinetyNineChallengeRemoteDataManager{
    
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    func fetchFavourites() -> Observable<[String]> {
        
        return Observable.create { [weak self] observer in
            let request = ListFavouritesRequest()
            self?.session.send(request: request) { result in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                        break
                    case .success(let data):
                        observer.onNext(data.listFavourites)
                        break
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func fetchFavourite(id: String) -> Observable<FavouriteDetailsResponse> {
        
        return Observable.create { [weak self] observer in
            let request = FavouriteDetailsRequest(id: id)
            self?.session.send(request: request) { result in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                        break
                    case .success(let data):
                        observer.onNext(data)
                        break
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
