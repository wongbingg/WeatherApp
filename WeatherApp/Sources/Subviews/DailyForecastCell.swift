//
//  DailyForecastCell.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

struct DailyForecastCellData {
    let day: String
    let iconName: String
    let minimumTemperature: String
    let maximumTemperature: String
    
    static func stub() -> Self {
        .init(day: "수", iconName: "01d", minimumTemperature: "-7", maximumTemperature: "11")
    }
}

final class DailyForecastCell: UITableViewCell {
    
    // MARK: - UI
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    private let dayLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let minimumTemperatureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let maximumTemperatureLabel: UILabel = {
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
            dayLabel,
            iconImage,
            minimumTemperatureLabel,
            maximumTemperatureLabel
        ]
            .forEach {
                mainStackView.addArrangedSubview($0)
            }
    }
    
    private func setupViewConstraints() {
        mainStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        iconImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
    }
    
    private func setupInitialSetting() {
        contentView.backgroundColor = .lightGray
    }
    
    func setupData(_ data: DailyForecastCellData) {
        dayLabel.text = data.day
        iconImage.image = UIImage(named: data.iconName)
        minimumTemperatureLabel.text = "최소: " + data.minimumTemperature + "º"
        maximumTemperatureLabel.text = "최대: " + data.maximumTemperature + "º"
    }
}
