import Foundation
import CoreLocation

struct Event: Identifiable {
    let id: String
    let title: String
    let date: String
    let location: String
    
    
    let category: String
    let description: String
    let imageSystemName: String

    var coordinate: CLLocationCoordinate2D {
        switch id {
        case "1":
            // Bahar Müzik Festivali - Kampüs Ana Alanı
            return CLLocationCoordinate2D(latitude: 38.49180, longitude: 27.70620)
            
        case "2":
            // Teknoloji ve Kariyer Fuarı - Teknoloji Fakültesi
            return CLLocationCoordinate2D(latitude: 38.49140, longitude: 27.70670)
            
        case "3":
            // Yapay Zeka Konferansı - Konferans Salonu
            return CLLocationCoordinate2D(latitude: 38.49195, longitude: 27.70675)
            
        case "4":
            // Mobil Uygulama Atölyesi - Bilgisayar Laboratuvarı
            return CLLocationCoordinate2D(latitude: 38.49120, longitude: 27.70615)
            
        case "5":
            // Girişimcilik Söyleşisi - Seminer Salonu
            return CLLocationCoordinate2D(latitude: 38.49165, longitude: 27.70585)
            
        case "6":
            // Ek etkinlik varsa yine kampüs çevresinde dursun
            return CLLocationCoordinate2D(latitude: 38.49130, longitude: 27.70555)
            
        default:
            // Varsayılan kampüs merkezi
            return CLLocationCoordinate2D(latitude: 38.49158, longitude: 27.70638)
        }
    }
}
extension Event {
    static let samples: [Event] = [
        Event(
            id: "1",
            title: "Kampüs Bahar Etkinliği",
            date: "25 Mayıs 2026 - 14:00",
            location: "Kampüs Bahçe Alanı",
            category: "Sosyal",
            description: "Öğrencilerin dönem sonunda bir araya gelerek sosyalleşebileceği, müzik ve çeşitli aktivitelerin yer aldığı kampüs etkinliğidir.",
            imageSystemName: "music.note"
        ),
        Event(
            id: "2",
            title: "Teknoloji ve Kariyer Buluşması",
            date: "28 Mayıs 2026 - 10:30",
            location: "Fakülte Etkinlik Alanı",
            category: "Kariyer",
            description: "Yazılım, mobil uygulama geliştirme, yapay zeka ve teknoloji sektöründe kariyer yapmak isteyen öğrenciler için düzenlenen bilgilendirme etkinliğidir.",
            imageSystemName: "briefcase"
        ),
        Event(
            id: "3",
            title: "Yapay Zeka ve Mobil Uygulamalar Semineri",
            date: "2 Haziran 2026 - 13:00",
            location: "Seminer Alanı",
            category: "Teknoloji",
            description: "Yapay zeka teknolojilerinin mobil uygulama geliştirme süreçlerinde nasıl kullanılabileceğini anlatan teknik seminer etkinliğidir.",
            imageSystemName: "cpu"
        ),
        Event(
            id: "4",
            title: "SwiftUI ile Mobil Uygulama Atölyesi",
            date: "5 Haziran 2026 - 15:00",
            location: "Uygulamalı Eğitim Alanı",
            category: "Atölye",
            description: "SwiftUI kullanılarak temel mobil uygulama ekranlarının tasarlanması, veri gösterimi ve kullanıcı etkileşimlerinin uygulanması üzerine hazırlanmış uygulamalı atölyedir.",
            imageSystemName: "iphone"
        ),
        Event(
            id: "5",
            title: "Öğrenci Girişimcilik Söyleşisi",
            date: "10 Haziran 2026 - 14:00",
            location: "Kampüs Sosyal Alanı",
            category: "Girişimcilik",
            description: "Öğrencilerin teknoloji tabanlı iş fikirleri geliştirmesi, proje üretmesi ve girişimcilik süreçlerini tanıması amacıyla düzenlenen söyleşi etkinliğidir.",
            imageSystemName: "lightbulb"
        )
    ]
}


            
            
        
    

