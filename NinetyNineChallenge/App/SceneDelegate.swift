//
//  SceneDelegate.swift
//  NinetyNineChallenge
//
//  Created by Eva Gonzalez Ferreira on 23/11/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    lazy var appCoordinator: AppCoordinator = {
        guard let window = self.window else { fatalError() }
        let coordinator = AppCoordinator(window: window)
        return coordinator
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let sceneWindow = UIWindow(windowScene: windowScene)
        window = sceneWindow
        appCoordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

