//
//  ThreeHourForecastCell.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

struct ThreeHourForecastCellData {
    let time: String
    let iconName: String
    // TODO: 로컬 리소스에 없으면 api 로 받아오기.
    //https://openweathermap.org/img/wn/10d@2x.png
    let temperature: String
    
    static func stub() -> Self {
        .init(time: "오전 11시", iconName: "01d", temperature: "-7")
    }
}

final class ThreeHourForecastCell: UICollectionViewCell {
    
    // MARK: - UI
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let temperatureLabel: UILabel = {
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
    
    private func commonInit() {
        setupViewHierarchy()
        setupViewConstraints()
    }
    
    private func setupViewHierarchy() {
        self.contentView.addSubview(mainStackView)
        [
            timeLabel,
            iconImage,
            temperatureLabel
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
    
    func setupData(_ data: ThreeHourForecastCellData) {
        timeLabel.text = data.time
        iconImage.image = UIImage(named: data.iconName)
        temperatureLabel.text = data.temperature + "º"
    }
}
