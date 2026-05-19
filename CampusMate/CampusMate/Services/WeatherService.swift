import Foundation

final class WeatherService {
    private let apiKey = "3b0ba3474566425381485708261805"
    
    func fetchCurrentWeather() async throws -> WeatherAPICurrent {
        var components = URLComponents(string: "https://api.weatherapi.com/v1/current.json")
        
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "38.49158,27.70638"),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "lang", value: "tr")
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
        return decodedData.current
    }
}
