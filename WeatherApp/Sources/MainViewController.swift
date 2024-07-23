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
        
        viewModel.fetchWeather(
            param: .init(
                lat: 37.5114,
                lon: 26.6616,
                appid: "f56f0b3525023d4e3dcd5263b763b404",
                cnt: 40,
                lang: "kr"
            )
        )
    }
    
    // MARK: - Binding
    
    private func bind() {
        bindTopViewData()
        bindThreeHourForecastCellData()
        bindDailyForecastCellData()
        bindMapData()
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
    
    private func bindMapData() {
        viewModel.mapData
            .bind { [weak self] coordinate in
                self?.weatherMapView.addPinAndFocus(at: coordinate.lat, longitude: coordinate.lon)
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
