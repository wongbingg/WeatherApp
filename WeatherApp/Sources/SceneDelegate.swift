//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let apiClient = APIClient()
        let weatherRepository = DefaultWeatherRepository(apiClient: apiClient)
        let fetchWeatherUseCase = DefaultFetchWeatherUseCase(repository: weatherRepository)
        let mainViewModel = DefuaultMainViewModel(fetchWeatherUseCase: fetchWeatherUseCase)
        window?.rootViewController = MainViewController(viewModel: mainViewModel)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
