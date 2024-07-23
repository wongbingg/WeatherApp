//
//  WeatherExtraInfoCell.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

final class WeatherExtraInfoCell: UICollectionViewCell {
    // MARK: - UI
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
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
        }
    }
    
    private func setupInitialSetting() {
        mainStackView.backgroundColor = .white
        mainStackView.layer.cornerRadius = 10
    }
}
