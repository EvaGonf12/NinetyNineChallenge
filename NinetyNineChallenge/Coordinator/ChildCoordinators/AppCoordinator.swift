//
//  AppCoordinator.swift
//  NinetyNineChallenge
//
//  Created by Eva Gonzalez Ferreira on 23/11/2020.
//

import UIKit

class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()
    
    // Remote Data Manager
    lazy var remoteDataManager: NinetyNineChallengeRemoteDataManager = {
        let remoteDataManager = NinetyNineChallengeRemoteDataManagerImp(session: sessionAPI)
        return remoteDataManager
    }()
    
    // Local Data Manager
    lazy var localDataManager: NinetyNineChallengeLocalDataManager = {
        let localDataManager = NinetyNineChallengeLocalDataManagerImpl()
        return localDataManager
    }()
    
    // Data Manager
    lazy var dataManager: NinetyNineChallengeDataManager = {
        let dataManager = NinetyNineChallengeDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()
    
    // Window
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    // ----------- INICIO -----------
    override func start() {
        let favouritesController = UINavigationController()
        favouritesController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.dark]
        favouritesController.navigationBar.tintColor = UIColor.dark
        let favouritesCoordinator = FavouritesCoordinator(presenter: favouritesController,
                                                          favouritesDataManager: self.dataManager,
                                                          favouriteDetailsDataManager: self.dataManager)
        addChildCoordinator(favouritesCoordinator)
        favouritesCoordinator.start()
         
        window.rootViewController = favouritesController
        window.makeKeyAndVisible()
    }
    
}

