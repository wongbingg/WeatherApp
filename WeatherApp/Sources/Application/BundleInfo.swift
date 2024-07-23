//
//  BundleInfo.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

public enum BundleInfo {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let apiKey = "OpenWeatherAPIKey"
        }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let apiKey: String = {
        guard let openWeatherAPIKey = BundleInfo.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        return openWeatherAPIKey
    }()
}

