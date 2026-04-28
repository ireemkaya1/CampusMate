import Foundation

// TODO: UNUserNotificationCenter entegrasyonu burada yapılacak.
// İzin isteme, bildirim planlama ve iptal işlemleri eklenecek.
//
// Info.plist için gerekli izin: (Xcode proje ayarlarından eklenmeli)
// Key: NSLocationWhenInUseUsageDescription
// Value: "Yakınındaki kampüs etkinliklerini haritada göstermek için konumuna ihtiyaç duyulmaktadır."
final class NotificationService {
    static let shared = NotificationService()
    private init() {}

    func schedule(for event: Event) {
        // TODO: UNUserNotificationCenter ile yerel bildirim ekle
    }

    func cancel(for event: Event) {
        // TODO: Bekleyen bildirimi iptal et
    }
}
