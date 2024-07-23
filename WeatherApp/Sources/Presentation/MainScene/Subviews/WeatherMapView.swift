//
//  WeatherMapView.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/22.
//

import UIKit
import MapKit

final class WeatherMapView: BaseView {
    
    // MARK: - UI
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "강수량"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        return mapView
    }()
    
    private let annotation = MKPointAnnotation()
    
    // MARK: - Overrides
    override func setupViewHierarchy() {
        self.addSubview(descriptionLabel)
        self.addSubview(mapView)
    }
    
    override func setupViewConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        mapView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    override func setupInitialSetting() {
        mapView.delegate = self
        mapView.layer.cornerRadius = 10
        backgroundColor = .white
        self.layer.cornerRadius = 10
        setPin()
    }
    
    // MARK: - Methods
    func setPinAndFocus(at latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 핀 추가
        annotation.coordinate = coordinate
        
        // 포커스 이동
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    private func setPin() {
        mapView.addAnnotation(annotation)
    }
}

extension WeatherMapView: MKMapViewDelegate {
    
}
