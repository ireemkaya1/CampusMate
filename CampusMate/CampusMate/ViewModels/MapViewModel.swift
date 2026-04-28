import Foundation

final class MapViewModel: ObservableObject {
    @Published var isLocationAuthorized = false

    func requestLocation() {
        // TODO: CLLocationManager entegrasyonu ekle
    }
}
