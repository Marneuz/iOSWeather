//
//  CoreLocation.swift
//  WeatherApp
//
//  Created by user241563 on 24/11/23.
//



import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    // Closures para actualizar la ubicación y manejar errores
    var onLocationUpdate: ((CLLocation, String) -> Void)?
    var onLocationError: ((Error) -> Void)?

    override init() {
        super.init()
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    

    // Solicitar permiso y comenzar a actualizar la ubicación
    func requestLocationPermission() {
        locationManager.requestAlwaysAuthorization()
        startLocationUpdates()
    }

    private func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }

    // Detener actualizaciones de ubicación
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }

    // Delegado de CLLocationManager: Actualización de ubicaciones
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        reverseGeocode(location: location)
    }

    // Delegado de CLLocationManager: Manejo de errores
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        onLocationError?(error)
    }

    // Delegado de CLLocationManager: Cambios en la autorización
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        case .denied, .restricted:
            
            onLocationError?(LocationError.permissionDenied)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            onLocationError?(LocationError.unknownError)
        }
    }

    // Geocodificación inversa para obtener el nombre de la ubicación
    private func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.onLocationError?(error)
                return
            }
            
            if let placemark = placemarks?.first {
                let placeName = placemark.locality ?? placemark.name ?? "Unknown Place"
                self.onLocationUpdate?(location, placeName)
            } else {
                self.onLocationError?(LocationError.placeNotFound)
            }
        }
    }

    // Función para obtener la última ubicación conocida
    func getCurrentLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        if let currentLocation = self.currentLocation {
            completion(.success(currentLocation))
        } else {
            completion(.failure(LocationError.locationUnavailable))
        }
    }
}

enum LocationError: Error {
    case permissionDenied
    case placeNotFound
    case unknownError
    case locationUnavailable
}
