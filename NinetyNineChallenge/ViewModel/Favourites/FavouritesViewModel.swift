import Foundation
import RxSwift

protocol FavouritesCoordinatorDelegate: class {
    func didSelect(favourite: String)
}

protocol FavouritesViewDelegate: class {
    func favouritesFetched()
    func errorFetchingFavourites(error: String)
}

class FavouritesViewModel {
    let title = "Favourites"
    weak var coordinatorDelegate: FavouritesCoordinatorDelegate?
    weak var viewDelegate: FavouritesViewDelegate?
    var favouritesDataManager: FavouritesDataManager
    var favViewModels: [FavouriteCellViewModel] = []
    
    private var disposeBag = DisposeBag()
    
    init(favouritesDataManager: FavouritesDataManager) {
        self.favouritesDataManager = favouritesDataManager
    }
    
    func viewWasLoaded() {
        self.getFavourites()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return favViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> FavouriteCellViewModel? {
        guard indexPath.row < favViewModels.count else { return nil }
        return favViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < favViewModels.count else { return }
        coordinatorDelegate?.didSelect(favourite: favViewModels[indexPath.row].favourite)
    }
    
    fileprivate func getFavourites() {
        return self.favouritesDataManager.fetchFavourites()
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] listFavourites in
                
                self?.favViewModels.removeAll()
                
                for fav in listFavourites {
                    let favCell = FavouriteCellViewModel(favourite: fav)
                    self?.favViewModels.append(favCell)
                }
                
                self?.viewDelegate?.favouritesFetched()
                
            } onError: { [weak self] error in
                self?.viewDelegate?.errorFetchingFavourites(error: error.localizedDescription)
            
            } onCompleted: {}.disposed(by: disposeBag)
        
    }
}
