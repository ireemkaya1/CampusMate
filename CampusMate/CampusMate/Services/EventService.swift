import Foundation

// TODO: Gerçek API entegrasyonu burada yapılacak.
// Endpoint URL'si ve URLSession async/await implementasyonu eklenecek.
// Şu an için sample data döndürür.
final class EventService {
    func fetchEvents() async -> [Event] {
        // TODO: URLSession ile gerçek API çağrısı ekle
        return Event.samples
    }
}
