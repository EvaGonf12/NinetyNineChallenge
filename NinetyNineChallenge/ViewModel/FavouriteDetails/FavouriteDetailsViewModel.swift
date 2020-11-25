import Foundation
import RxSwift

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
    
    private var disposeBag = DisposeBag()

    init(favId: String, favouriteDetailsDataManager: FavouriteDetailsDataManager) {
        self.title = "Fav Details"
        self.favId = favId
        self.favouriteDetailsDataManager = favouriteDetailsDataManager
    }
    
    func viewDidLoad() {
        self.getFavouriteDetails()
    }
        
    fileprivate func getFavouriteDetails() {
        return self.favouriteDetailsDataManager.fetchFavourite(id: self.favId)
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] favDetails in
                self?.name = favDetails.name
                self?.hot = favDetails.hot
                self?.ricCode = favDetails.ricCode
                self?.category = favDetails.category
                self?.viewDelegate?.favouriteDetailsFetched()
            } onError: { [weak self] error in
                self?.viewDelegate?.errorFetchingFavouriteDetails(error: error.localizedDescription)
            } onCompleted: {}.disposed(by: disposeBag)
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.favouriteDetailaBackButtonTapped()
    }
    
    func alertDismiss() {
        self.coordinatorDelegate?.favouriteDetailaBackButtonTapped()
    }

}
