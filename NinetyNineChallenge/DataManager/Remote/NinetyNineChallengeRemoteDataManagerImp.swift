import Foundation

final class NinetyNineChallengeRemoteDataManagerImp:  NinetyNineChallengeRemoteDataManager{
   
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    func fetchFavourites(completion: @escaping (Result<ListFavouritesResponse, Error>) -> ()) {
        let request = ListFavouritesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchFavourite(id: String, completion: @escaping (Result<FavouriteDetailsResponse, Error>) -> ()) {
        let request = FavouriteDetailsRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
}
