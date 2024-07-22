//
//  MainViewController.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

import RxSwift
import SnapKit

final class MainViewController: BaseViewController {
    
    private let viewModel: MainViewModel
    private var disposeBag = DisposeBag()
    
    // MARK: UI
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 0, bottom: 10, right: 0)
        return stackView
    }()
    
    private let topView = TopView()
    private let threeHourForecastView = ThreeHourForecastView()
    private let dailyForecastView = DailyForecastView()
    private let weatherMapView = WeatherMapView()
    private let weatherExtraInfoView = WeatherExtraInfoView()
    
    // MARK: Initializers
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override func setupViewHierarchy() {
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        [
            topView,
            threeHourForecastView,
            dailyForecastView,
            weatherMapView,
            weatherExtraInfoView
        ]
            .forEach {
                mainStackView.addArrangedSubview($0)
            }
    }
    
    override func setupViewConstraints() {
        mainScrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            
        }
        mainStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(mainScrollView)
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
        }
        threeHourForecastView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(120)
        }
        dailyForecastView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(230)
        }
        weatherMapView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(300)
        }
        weatherExtraInfoView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(weatherExtraInfoView.snp.width)
        }
    }
    
    override func setupInitialSetting() {
        view.backgroundColor = .lightGray
        bind()
//        viewModel.fetchWeather(param: <#T##WeatherRequest#>)
        
        
//        topView.setupData(.init(cityName: "Seoul", temperature: "-7", weather: "맑음", maximumTemperature: "-1", minimumTemperature: "-11"))
//        threeHourForecastView.setupData([.stub(), .stub(), .stub(), .stub(), .stub(), .stub(), .stub(), .stub()])
//        dailyForecastView.setupData([.stub(), .stub(), .stub(), .stub(), .stub()])
//        weatherMapView.addPinAndFocus(at: 47.6422, longitude: 16.082741)
//        weatherExtraInfoView.setupData([
//            .init(header: "습도", value: "56%", footer: nil),
//            .init(header: "구름", value: "50%", footer: nil),
//            .init(header: "바람 속도", value: "1.97m/s", footer: "강풍: 3.39m/s"),
//            .init(header: "기압", value: "1,030\nhpa", footer: nil)
//        ])
    }
    
    // MARK: Binding
    
    private func bind() {
        bindTopViewData()
        bindThreeHourForecastCellData()
        bindDailyForecastCellData()
        bindWeatherExtraInfoCellData()
    }
    
    private func bindTopViewData() {
        viewModel.topViewData
            .bind { [weak self] data in
                self?.topView.setupData(data)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindThreeHourForecastCellData() {
        viewModel.threeHourForecastCellData
            .bind { [weak self] list in
                self?.threeHourForecastView.setupData(list)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindDailyForecastCellData() {
        viewModel.dailyForecastCellData
            .bind { [weak self] list in
                self?.dailyForecastView.setupData(list)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindWeatherExtraInfoCellData() {
        viewModel.weatherExtraInfoCellData
            .bind { [weak self] list in
                self?.weatherExtraInfoView.setupData(list)
            }
            .disposed(by: disposeBag)
    }
}
