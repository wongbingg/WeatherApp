//
//  ThreeHourForecastView.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa

final class ThreeHourForecastView: BaseView {
    
    private var dataSource: BehaviorRelay<[ThreeHourForecastCellData]> = .init(value: [])
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 70, height: 100)
        layout.minimumLineSpacing = 20
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ThreeHourForecastCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .lightGray
        return collectionView
    }()
    
    // MARK: - Overrides
    
    override func setupViewHierarchy() {
        self.addSubview(descriptionLabel)
        self.addSubview(weatherCollectionView)
    }
    
    override func setupViewConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        weatherCollectionView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom)
        }
    }
    
    override func setupInitialSetting() {
        setupCollectionViewData()
    }
    
    // MARK: - Methods
    func setupData(_ data: [ThreeHourForecastCellData]) {
        descriptionLabel.text = "돌풍의 풀속은 최대 4m/s입니다."
        dataSource.accept(data)
    }
    
    private func setupCollectionViewData() {
        dataSource
            .bind(to: weatherCollectionView.rx.items(
                cellIdentifier: ThreeHourForecastCell.defaultReuseIdentifier,
                cellType: ThreeHourForecastCell.self)
            ) { [weak self] index, item, cell in
                
                guard let self = self else { return }
                cell.setupData(item)
            }
            .disposed(by: disposeBag)
    }
}
