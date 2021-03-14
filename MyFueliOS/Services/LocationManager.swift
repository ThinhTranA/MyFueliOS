//
//  LocationManager.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 13/3/21.
//

import Foundation
import CoreLocation
import Combine


class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var location: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var suburb: String? {
        willSet{
            objectWillChange.send()
        }
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    private func lookupSuburbFromLocation() {
        guard let location = self.location else { return}
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
          if error == nil {
            let placemark = places?[0]
//            let address = "\(placemark.subThoroughfare ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")"

            self.suburb = placemark?.locality
          }
        })
      }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        
        if suburb == nil {
            lookupSuburbFromLocation()
        }
        print(#function, location)
    }

}
