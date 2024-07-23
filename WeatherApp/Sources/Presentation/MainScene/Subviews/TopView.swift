//
//  TopView.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

import SnapKit

final class TopView: BaseView {
    
    // MARK: - UI
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textColor = .white
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    
    private let temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let maximumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let minimumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Overrides
    override func setupViewHierarchy() {
        
        self.addSubview(mainStackView)
        
        [
            cityNameLabel,
            temperatureLabel,
            weatherLabel,
            temperatureStackView
        ]
            .forEach {
                mainStackView.addArrangedSubview($0)
            }
        
        [
            maximumTemperatureLabel,
            minimumTemperatureLabel
        ]
            .forEach{
                temperatureStackView.addArrangedSubview($0)
            }
    }
    
    override func setupViewConstraints() {
        mainStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func setupInitialSetting() {
//        mainStackView.backgroundColor = .white
    }
    
    // MARK: - Methods
    func setupData(_ data: TopViewData) {
        cityNameLabel.text = data.cityName
        temperatureLabel.text = data.temperature + "º"
        weatherLabel.text = data.weather
        maximumTemperatureLabel.text = "최고: " + data.maximumTemperature + "º"
        minimumTemperatureLabel.text = "최저: " + data.minimumTemperature + "º"
    }
}
