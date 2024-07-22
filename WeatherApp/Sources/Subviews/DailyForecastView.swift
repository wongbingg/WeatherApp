//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa

final class DailyForecastView: BaseView {
    
    private var dataSource: BehaviorRelay<[DailyForecastCellData]> = .init(value: [])
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DailyForecastCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .lightGray
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: - Overrides
    
    override func setupViewHierarchy() {
        self.addSubview(descriptionLabel)
        self.addSubview(weatherTableView)
    }
    
    override func setupViewConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        weatherTableView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom)
        }
    }
    
    override func setupInitialSetting() {
        setupTableViewData()
        setupTableViewDelegate()
    }
    
    private func setupTableViewData() {
        dataSource
            .bind(to: weatherTableView.rx.items(
                cellIdentifier: DailyForecastCell.defaultReuseIdentifier,
                cellType: DailyForecastCell.self)
            ) { [weak self] index, item, cell in
                
                guard let self = self else { return }
                cell.setupData(item)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTableViewDelegate() {
        weatherTableView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                self?.weatherTableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)

    }
    
    func setupData(_ data: [DailyForecastCellData]) {
        descriptionLabel.text = "5일간의 일기예보"
        dataSource.accept(data)
    }
}
