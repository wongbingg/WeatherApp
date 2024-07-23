//
//  SearchQueryCell.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import UIKit

struct SearchQueryCellData {
    let cityName: String
    let countryCode: String
    let lat: Double
    let lon: Double
    
    static func stub() -> Self {
        .init(cityName: "Korea", countryCode: "Seoul", lat: 0, lon: 0)
    }
}

final class SearchQueryCell: UITableViewCell {
    
    // MARK: - UI
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
        return stackView
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let countryCodeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupViewHierarchy()
        setupViewConstraints()
        setupInitialSetting()
    }
    
    private func setupViewHierarchy() {
        self.contentView.addSubview(mainStackView)
        [
            cityNameLabel,
            countryCodeLabel,
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
    }
    
    func setupData(_ data: SearchQueryCellData) {
        cityNameLabel.text = data.cityName
        countryCodeLabel.text = data.countryCode
    }
}
