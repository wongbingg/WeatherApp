//
//  UIViewController+.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/24.
//

import UIKit

import SnapKit

extension UIViewController {
    
    private static var loadingViewTag = 100
    
    func showLoadingView() {
        guard view.viewWithTag(UIViewController.loadingViewTag) == nil else { return }
        
        let loadingView = LoadingView(frame: view.bounds)
        loadingView.tag = UIViewController.loadingViewTag
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            loadingView.alpha = 1.0
        }
    }
    
    func hideLoadingView() {
        guard let loadingView = view.viewWithTag(UIViewController.loadingViewTag) else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            loadingView.alpha = 0.0
        }) { _ in
            loadingView.removeFromSuperview()
        }
    }
}
