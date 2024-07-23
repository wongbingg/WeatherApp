//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa

protocol SearchViewControllerDelegate: AnyObject {
    func searchButtonTapped(with lat: Double, lon: Double)
}

final class SearchViewController: BaseViewController {
    
    private var dataSource: BehaviorRelay<[SearchQueryCellData]> = .init(value: [])
    private var disposeBag = DisposeBag()
    private let viewModel: SearchViewModel
    weak var delegate: SearchViewControllerDelegate?
    
    // MARK: UI
    private let queryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchQueryCell.self)
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = 80
        return tableView
    }()
    
    // MARK: Initializers
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override func setupViewHierarchy() {
        view.addSubview(queryTableView)
    }
    
    override func setupViewConstraints() {
        queryTableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupInitialSetting() {
        setupTableViewData()
        setupTableViewDelegate()
        viewModel.fetchCityList()
    }
    
    func setData(_ text: String) {
        let filteredQueryList = viewModel.searchQueryList.value.filter {
            $0.cityName.contains(text)
        }
        dataSource.accept(filteredQueryList)
    }
    
    private func setupTableViewData() {
        dataSource
            .bind(to: queryTableView.rx.items(
                cellIdentifier: SearchQueryCell.defaultReuseIdentifier,
                cellType: SearchQueryCell.self)
            ) { [weak self] index, item, cell in
                cell.setupData(item)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTableViewDelegate() {
        queryTableView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                guard let self = self else { return }
                guard let index = indexPath.element else { return }
                
                queryTableView.deselectRow(at: index, animated: true)
                let data = dataSource.value[index.row]
                delegate?.searchButtonTapped(with: data.lat, lon: data.lon)
            }
            .disposed(by: disposeBag)
    }
}
