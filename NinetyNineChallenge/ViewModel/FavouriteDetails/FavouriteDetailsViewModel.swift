import Foundation


protocol FavouriteDetailsCoordinatorDelegate: class {
    func favouriteDetailaBackButtonTapped()
}

protocol FavouriteDetailsViewDelegate: class {
    func favouriteDetailsFetched()
    func errorFetchingFavouriteDetails(error: String)
}

class FavouriteDetailsViewModel {
    var title: String
    var name: String?
    var hot: Int?
    var ricCode: String?
    var category: String?
    
    weak var viewDelegate: FavouriteDetailsViewDelegate?
    weak var coordinatorDelegate: FavouriteDetailsCoordinatorDelegate?
    let favouriteDetailsDataManager: FavouriteDetailsDataManager
    let favId: String
    
    init(favId: String, favouriteDetailsDataManager: FavouriteDetailsDataManager) {
        self.title = "Fav Details"
        self.favId = favId
        self.favouriteDetailsDataManager = favouriteDetailsDataManager
    }
    
    func viewDidLoad() {
        self.favouriteDetailsDataManager.fetchFavourite(id: self.favId, completion: {[weak self] result in
            switch result {
                case .failure(let error):
                    self?.viewDelegate?.errorFetchingFavouriteDetails(error: error.localizedDescription)
                case .success(let favDetails):
                    self?.name = favDetails.name
                    self?.hot = favDetails.hot
                    self?.ricCode = favDetails.ricCode
                    self?.category = favDetails.category
                    self?.viewDelegate?.favouriteDetailsFetched()
            }
        })
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.favouriteDetailaBackButtonTapped()
    }
    
    func alertDismiss() {
        self.coordinatorDelegate?.favouriteDetailaBackButtonTapped()
    }
}
