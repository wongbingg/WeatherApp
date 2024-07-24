//
//  FiveDayForecastView.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa
import SnapKit

final class FiveDayForecastView: BaseView {
    
    private var dataSource: BehaviorRelay<[FiveDayForecastCellData]> = .init(value: [])
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FiveDayForecastCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .lightGray
        tableView.isScrollEnabled = false
        tableView.rowHeight = 40
        return tableView
    }()
    
    // MARK: - Overrides
    
    override func setupViewHierarchy() {
        self.addSubview(descriptionLabel)
        self.addSubview(weatherTableView)
    }
    
    override func setupViewConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(10)
        }
        weatherTableView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(descriptionLabel.snp.bottom)
        }
    }
    
    override func setupInitialSetting() {
        setupTableViewData()
        setupTableViewDelegate()
        backgroundColor = .white
        weatherTableView.backgroundColor = .white
        self.layer.cornerRadius = 10
    }
    
    private func setupTableViewData() {
        dataSource
            .bind(to: weatherTableView.rx.items(
                cellIdentifier: FiveDayForecastCell.defaultReuseIdentifier,
                cellType: FiveDayForecastCell.self)
            ) { [weak self] index, item, cell in
                
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
    
    func setupData(_ data: [FiveDayForecastCellData]) {
        descriptionLabel.text = "5일간의 일기예보"
        dataSource.accept(data)
    }
}
