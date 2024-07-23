//
//  MainSceneDIContainer.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import UIKit

final class MainSceneDIContainer {
    // MARK: - ViewControllers
    func makeMainViewController() -> MainViewController {
        let viewModel = makeMainViewModel()
        return MainViewController(viewModel: viewModel)
    }
    
    // MARK: - ViewModels
    func makeMainViewModel() -> MainViewModel {
        return DefaultMainViewModel(
            fetchWeatherUseCase: makeFetchWeatherUseCase()
        )
    }
    
    // MARK: - UseCases
    func makeFetchWeatherUseCase() -> FetchWeatherUseCase {
        return DefaultFetchWeatherUseCase(repository: makeWeatherRepository())
    }
    
    // MARK: - Repositories
    func makeWeatherRepository() -> WeatherRepository {
        return DefaultWeatherRepository(apiClient: APIClient())
    }
}
