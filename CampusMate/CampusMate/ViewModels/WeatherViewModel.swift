import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var temperatureText: String = "--°C"
    @Published var windText: String = "-- km/s"
    @Published var conditionText: String = "Yükleniyor"
    @Published var iconName: String = "cloud.sun.fill"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var lastUpdatedText: String = ""
    
    private let weatherService = WeatherService()
    private var hasLoaded = false
    
    func fetchWeather() {
        guard hasLoaded == false else { return }
        hasLoaded = true
        
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                let weather = try await weatherService.fetchCurrentWeather()
                
                temperatureText = "\(Int(weather.tempC.rounded()))°C"
                windText = "\(Int(weather.windKph.rounded())) km/s"
                conditionText = weather.condition.text
                lastUpdatedText = "Son güncelleme: \(weather.lastUpdated)"
                
                iconName = iconNameForWeather(
                    code: weather.condition.code,
                    isDay: weather.isDay == 1
                )
                
            } catch {
                errorMessage = "Hava durumu alınamadı"
                conditionText = "Bağlantı hatası"
                lastUpdatedText = ""
                iconName = "exclamationmark.triangle.fill"
                print("WeatherAPI hatası: \(error.localizedDescription)")
            }
            
            isLoading = false
        }
    }
    
    private func iconNameForWeather(code: Int, isDay: Bool) -> String {
        switch code {
        case 1000:
            return isDay ? "sun.max.fill" : "moon.stars.fill"
            
        case 1003:
            return isDay ? "cloud.sun.fill" : "cloud.moon.fill"
            
        case 1006, 1009:
            return "cloud.fill"
            
        case 1030, 1135, 1147:
            return "cloud.fog.fill"
            
        case 1063, 1150, 1153, 1180, 1183:
            return "cloud.drizzle.fill"
            
        case 1186, 1189, 1192, 1195, 1240, 1243, 1246:
            return "cloud.rain.fill"
            
        case 1066, 1210, 1213, 1216, 1219, 1222, 1225:
            return "cloud.snow.fill"
            
        case 1087, 1273, 1276:
            return "cloud.bolt.rain.fill"
            
        default:
            return isDay ? "cloud.sun.fill" : "cloud.moon.fill"
        }
    }
}
