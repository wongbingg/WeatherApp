//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupViewConstraints()
        setupInitialSetting()
    }
    
    func setupViewHierarchy() {
        // 서브클래스에서 오버라이드하여 뷰 계층을 설정.
    }
    
    func setupViewConstraints() {
        // 서브클래스에서 오버라이드하여 제약 조건을 설정.
    }
    
    func setupInitialSetting() {
        // 서브클래스에서 오버라이드하여 초기세팅 설정.
    }
}
