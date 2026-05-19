import Foundation
import MapKit
import CoreLocation
import Combine

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.49158, longitude: 27.70638),
        span: MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.012)
    )
    
    @Published var isLocationAuthorized = false
    
    private let locationManager = CLLocationManager()
    private var didCenterOnUserLocation = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
    }
    
    func requestUserLocation() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationAuthorized = true
            locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            isLocationAuthorized = false
            print("Konum izni reddedildi veya kısıtlandı.")
            
        @unknown default:
            isLocationAuthorized = false
        }
    }
    
    private func checkLocationPermission() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationAuthorized = true
            locationManager.startUpdatingLocation()
            
        case .notDetermined, .denied, .restricted:
            isLocationAuthorized = false
            
        @unknown default:
            isLocationAuthorized = false
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.isLocationAuthorized = true
            
            if self.didCenterOnUserLocation == false {
                self.region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.012)
                )
                
                self.didCenterOnUserLocation = true
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
}
