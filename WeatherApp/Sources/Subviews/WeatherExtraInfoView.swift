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
    
    private let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 70, height: 100)
        layout.minimumLineSpacing = 20
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherExtraInfoCell.self)
        collectionView.showsHorizontalScrollIndicator = false
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
        weatherCollectionView.backgroundColor = .white
    }
    
    // MARK: - Methods
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
    
    func setupData(_ data: [WeatherExtraInfoCellData]) {
        
        dataSource.accept(data)
    }
}
