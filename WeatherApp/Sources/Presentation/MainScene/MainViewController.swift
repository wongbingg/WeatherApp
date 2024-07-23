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
    
    private lazy var searchController = UISearchController(searchResultsController: searchResultController)
    private let searchResultController: SearchViewController
    private let topView = TopView()
    private let threeHourForecastView = ThreeHourForecastView()
    private let dailyForecastView = DailyForecastView()
    private let weatherMapView = WeatherMapView()
    private let weatherExtraInfoView = WeatherExtraInfoView()
    
    // MARK: Initializers
    init(viewModel: MainViewModel, searchResultController: SearchViewController) {
        self.viewModel = viewModel
        self.searchResultController = searchResultController
        super.init(nibName: nil, bundle: nil)
        self.searchResultController.delegate = self
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
        setupSearchController()
        bind()
        
        viewModel.fetchWeather(
            param: .init(
                lat: 36.783611,
                lon: 127.004173,
                appid: BundleInfo.apiKey,
                cnt: 40,
                lang: "kr"
            )
        )
    }
    
    private func setupSearchController() {
        // Search Controller 설정
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색어를 입력하세요"
        
        // 네비게이션 아이템에 Search Controller 추가
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // 검색창이 사라지지 않도록 설정
        definesPresentationContext = true
    }
    
    // MARK: - Binding
    private func bind() {
        bindSearchText()
        bindTopViewData()
        bindThreeHourForecastCellData()
        bindDailyForecastCellData()
        bindMapData()
        bindWeatherExtraInfoCellData()
    }
    
    private func bindSearchText() {
        viewModel.searchText
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [weak self] text in
                self?.searchResultController.setData(text)
            }
            .disposed(by: disposeBag)
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

// MARK: - SearchBar

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        viewModel.putSearchText(searchText ?? "")
    }
}

extension MainViewController: SearchViewControllerDelegate {
    
    func searchButtonTapped(with lat: Double, lon: Double) {
        viewModel.fetchWeather(
            param: .init(
                lat: lat,
                lon: lon,
                appid: BundleInfo.apiKey,
                cnt: 40,
                lang: "kr"
            )
        )
        searchController.isActive = false
    }
}
