//
//  WeatherExtraInfoView.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa

final class WeatherExtraInfoView: BaseView {
    
    private var dataSource: BehaviorRelay<[WeatherExtraInfoCellData]> = .init(value: [])
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.width/2 - 20)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherExtraInfoCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .lightGray
        return collectionView
    }()
    
    // MARK: - Overrides
    override func setupViewHierarchy() {
        self.addSubview(weatherCollectionView)
    }
    override func setupViewConstraints() {
        weatherCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    override func setupInitialSetting() {
        setupCollectionViewData()
        backgroundColor = .white
        weatherCollectionView.backgroundColor = .lightGray
    }
    
    // MARK: - Methods
    func setupData(_ data: [WeatherExtraInfoCellData]) {
        
        dataSource.accept(data)
    }
    
    private func setupCollectionViewData() {
        dataSource
            .bind(to: weatherCollectionView.rx.items(
                cellIdentifier: WeatherExtraInfoCell.defaultReuseIdentifier,
                cellType: WeatherExtraInfoCell.self)
            ) { [weak self] index, item, cell in
                
                guard let self = self else { return }
                cell.setupData(item)
            }
            .disposed(by: disposeBag)
    }
}
