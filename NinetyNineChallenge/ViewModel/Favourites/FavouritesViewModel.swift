import Foundation

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
    
    func getFavourites() {
        self.favouritesDataManager.fetchAllFavourites {[weak self] result in
            switch result {
                case .failure(let error):
                    self?.viewDelegate?.errorFetchingFavourites(error: error.localizedDescription)
                case .success(let response):
                    self?.favViewModels.removeAll()
                    
                    let favList = response.result
                    
                    for fav in favList {
                        let favCell = FavouriteCellViewModel(favourite: fav)
                        self?.favViewModels.append(favCell)
                    }
                    self?.viewDelegate?.favouritesFetched()
            }
        }
    }
}
