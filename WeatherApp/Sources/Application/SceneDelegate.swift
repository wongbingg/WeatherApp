//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let appDIContainer = AppDIContainer()

    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainSceneDIContainer = appDIContainer.makeMainSceneDIContainer()
        let mainViewController = mainSceneDIContainer.makeMainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
