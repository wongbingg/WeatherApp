//
//  WeatherExtraInfoCell.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

struct WeatherExtraInfoCellData {
    let header: String
    let value: String
    let footer: String?
}

final class WeatherExtraInfoCell: UICollectionViewCell {
    // MARK: - UI
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupData(_ data: WeatherExtraInfoCellData) {
        headerLabel.text = data.header
        valueLabel.text = data.value
        footerLabel.text = data.footer
    }
    
    private func commonInit() {
        setupViewHierarchy()
        setupViewConstraints()
        setupInitialSetting()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(mainStackView)
        [
            headerLabel,
            valueLabel,
            footerLabel
        ]
            .forEach {
                mainStackView.addArrangedSubview($0)
            }
    }
    
    private func setupViewConstraints() {
        mainStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.bounds.width/2 - 60)
        }
    }
    
    private func setupInitialSetting() {
        mainStackView.backgroundColor = .brown
    }
}
