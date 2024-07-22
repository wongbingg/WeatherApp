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
        return label
    }()
    private let mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        return mapView
    }()
    
    // MARK: - Overrides
    override func setupViewHierarchy() {
        self.addSubview(descriptionLabel)
        self.addSubview(mapView)
    }
    
    override func setupViewConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        mapView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func setupInitialSetting() {
        mapView.delegate = self
        backgroundColor = .white
    }
    
    // MARK: - Methods
    func addPinAndFocus(at latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 핀 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Destination"
        mapView.addAnnotation(annotation)
        
        // 포커스 이동
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}

extension WeatherMapView: MKMapViewDelegate {
    
}
