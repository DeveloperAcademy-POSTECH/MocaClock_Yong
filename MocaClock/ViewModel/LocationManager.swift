//
//  LocationManager.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import Foundation
import CoreLocation
import MapKit


final class LocationManager:  NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var location: CLLocation?
    @Published var currentPlacemark: CLPlacemark?

    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    
    override init() {
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
        let local: Locale = Locale(identifier: "en_us")
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: local) { (placemarks, error) in
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
