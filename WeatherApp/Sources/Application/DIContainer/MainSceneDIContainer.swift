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
        let searchResultController = makeSearchViewController()
        
        return MainViewController(
            viewModel: viewModel,
            searchResultController: searchResultController
        )
    }
    
    func makeSearchViewController() -> SearchViewController {
        let viewModel = makeSearchViewModel()
        return SearchViewController(viewModel: viewModel)
    }
    
    // MARK: - ViewModels
    func makeMainViewModel() -> MainViewModel {
        return DefaultMainViewModel(
            fetchWeatherUseCase: makeFetchWeatherUseCase()
        )
    }
    
    func makeSearchViewModel() -> SearchViewModel {
        return DefaultSearchViewModel(fetchCityUseCase: makeFetchCityUseCase())
    }
    
    // MARK: - UseCases
    func makeFetchWeatherUseCase() -> FetchWeatherUseCase {
        return DefaultFetchWeatherUseCase(repository: makeWeatherRepository())
    }
    
    func makeFetchCityUseCase() -> FetchCityUseCase {
        return DefaultFetchCityUseCase(cityRepository: makeCityRepository())
    }
    
    // MARK: - Repositories
    func makeWeatherRepository() -> WeatherRepository {
        return DefaultWeatherRepository(apiClient: APIClient())
    }
    
    func makeCityRepository() -> CityRepository {
        return DefaultCityRepository()
    }
}
