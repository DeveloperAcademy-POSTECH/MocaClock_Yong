//
//  LocationManager.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import Foundation
import CoreLocation
import MapKit


final class LocationManager:  NSObject, ObservableObject {
    @Published var location: CLLocation?
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    @Published var placeName = ""
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
//        locationManager.requestLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
    @MainActor
    func forwardGeocoding(address: String) async {
        let geocoder = CLGeocoder()
        var placemarks: [CLPlacemark] = []
        do { placemarks = try await geocoder.geocodeAddressString(address) }
        catch { print(error.localizedDescription) }
        if let location = placemarks.first?.location {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            }
        }
    
    @MainActor
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        let geocoder = CLGeocoder()
        var placemarks: [CLPlacemark] = []
        let location = CLLocation(latitude: latitude, longitude: longitude)
        do { placemarks = try await geocoder.reverseGeocodeLocation(location) }
        catch {
            print(error.localizedDescription)
        }
        if let location = placemarks.first?.address {
            placeName = location
        }
    }
}
