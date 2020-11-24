//
//  FavouritesCoordinator.swift
//  NinetyNineChallenge
//
//  Created by Eva Gonzalez Ferreira on 23/11/2020.
//

import UIKit

class FavouritesCoordinator: Coordinator {

    let presenter: UINavigationController
    let favouritesDataManager: FavouritesDataManager
    let favouriteDetailsDataManager: FavouriteDetailsDataManager
    var favouritesViewModel: FavouritesViewModel?
    
    init(presenter: UINavigationController,
         favouritesDataManager: FavouritesDataManager,
         favouriteDetailsDataManager: FavouriteDetailsDataManager) {

        self.presenter = presenter
        self.favouritesDataManager = favouritesDataManager
        self.favouriteDetailsDataManager = favouriteDetailsDataManager
    }
    
    override func start() {
        let favouritesViewModel = FavouritesViewModel(favouritesDataManager: favouritesDataManager)
        let favouritesViewController = FavouritesViewController(viewModel: favouritesViewModel)
        favouritesViewController.title = NSLocalizedString("Favourites", comment: "")
        favouritesViewModel.viewDelegate = favouritesViewController
        favouritesViewModel.coordinatorDelegate = self
        self.favouritesViewModel = favouritesViewModel
        presenter.pushViewController(favouritesViewController, animated: false)
    }

    override func finish() {}
}

extension FavouritesCoordinator: FavouritesCoordinatorDelegate {
    func didSelect(favourite: String) {
        let favouriteDetailViewModel = FavouriteDetailsViewModel(favId: favourite, favouriteDetailsDataManager: self.favouriteDetailsDataManager)
        let favouriteDetailViewController = FavouriteDetailViewController(viewModel: favouriteDetailViewModel)
        favouriteDetailViewController.title = NSLocalizedString("Topic Details", comment: "")
        favouriteDetailViewModel.viewDelegate = favouriteDetailViewController
        favouriteDetailViewModel.coordinatorDelegate = self
        self.presenter.pushViewController(favouriteDetailViewController, animated: true)
    }
}

extension FavouritesCoordinator: FavouriteDetailsCoordinatorDelegate {
    func favouriteDetailaBackButtonTapped() {
        self.presenter.popViewController(animated: true)
    }
}
