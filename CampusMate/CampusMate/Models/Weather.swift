import Foundation

struct WeatherAPIResponse: Decodable {
    let current: WeatherAPICurrent
}

struct WeatherAPICurrent: Decodable {
    let tempC: Double
    let isDay: Int
    let condition: WeatherAPICondition
    let windKph: Double
    let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case lastUpdated = "last_updated"
    }
}

struct WeatherAPICondition: Decodable {
    let text: String
    let icon: String
    let code: Int
}
