//
//  AppDIContainer.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

final class AppDIContainer {
    
    func makeMainSceneDIContainer() -> MainSceneDIContainer {
        return MainSceneDIContainer()
    }
}
