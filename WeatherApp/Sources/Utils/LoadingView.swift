//
//  LoadingView.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/24.
//

import UIKit

final class LoadingView: BaseView {
    // MARK: UI
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: Overrides
    override func setupViewHierarchy() {
        addSubview(activityIndicator)
    }
    
    override func setupViewConstraints() {
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    override func setupInitialSetting() {
        backgroundColor = .lightGray
    }
}
