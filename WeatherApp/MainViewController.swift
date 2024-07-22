//
//  MainViewController.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    // MARK: UI
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let topView = TopView()
    private let threeHourForecastView = ThreeHourForecastView()
    private let dailyForecastView = DailyForecastView()
    private let weatherMapView = WeatherMapView()
    private let weatherInfoView = WeatherInfoView()
   
    
    // MARK: Overrides
    override func setupViewHierarchy() {
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        [
            topView,
            threeHourForecastView,
            dailyForecastView,
            weatherMapView,
            weatherInfoView
        ]
            .forEach {
                mainStackView.addArrangedSubview($0)
            }
    }
    
    override func setupViewConstraints() {
        mainScrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        mainStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(mainScrollView)
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
        }
        threeHourForecastView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(100)
        }
        dailyForecastView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }
        weatherMapView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(300)
        }
        weatherInfoView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
    
    override func setupInitialSetting() {
        view.backgroundColor = .lightGray
        topView.setupData(.init(cityName: "Seoul", temperature: "-7", weather: "맑음", maximumTemperature: "-1", minimumTemperature: "-11"))
        threeHourForecastView.setupData([.stub(), .stub(), .stub(), .stub(), .stub(), .stub(), .stub(), .stub()])
        dailyForecastView.setupData([.stub(), .stub(), .stub(), .stub(), .stub(), .stub(), .stub(), .stub()])
        weatherMapView.addPinAndFocus(at: 47.6422, longitude: 16.082741)
        weatherInfoView.setupData([
            .init(header: "습도", value: "56%", footer: nil),
            .init(header: "구름", value: "50%", footer: nil),
            .init(header: "바람 속도", value: "1.97m/s", footer: "강풍: 3.39m/s"),
            .init(header: "기압", value: "1,030\nhpa", footer: nil)
        ])
    }
}
