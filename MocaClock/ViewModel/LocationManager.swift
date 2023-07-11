//
//  LocationManager.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import Foundation
import CoreLocation
import MapKit

#warning("설정값에 따라서 다른 상태 다르게 처리해줌")


final class LocationManager:  NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var location: CLLocation?
    @Published var currentPlacemark: CLPlacemark?

    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    
    override init() {
        // 상태에 따라서 화면 상태를 띄워주어야 하는 디테일 일단 넘어감
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        requestPermission()
    }
    
}

extension LocationManager {
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        fetchCountryAndCity(for: locations.last)
    }

    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.currentPlacemark = placemarks?.first
        }
    }
    func requestLocation() {
           locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
