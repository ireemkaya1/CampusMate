import Foundation

struct Event: Identifiable {
    let id: String
    let title: String
    let date: String
    let location: String
    let category: String
    let description: String
    let imageSystemName: String
}

// MARK: - Sample Data (Servis entegrasyonu tamamlanana kadar kullanılır)
extension Event {
    static let samples: [Event] = [
        Event(
            id: "1",
            title: "Bahar Müzik Festivali",
            date: "15 Mayıs 2025 • 17:00",
            location: "Kampüs Ana Sahnesi",
            category: "Müzik",
            description: "Kampüsümüzün geleneksel bahar festivali. Öğrenci toplulukları ve konuk sanatçılarla dolu bir gece.",
            imageSystemName: "music.note"
        ),
        Event(
            id: "2",
            title: "Teknoloji ve Kariyer Fuarı",
            date: "20 Mayıs 2025 • 10:00",
            location: "Kültür ve Kongre Merkezi",
            category: "Kariyer",
            description: "Türkiye'nin önde gelen teknoloji şirketleriyle buluşma fırsatı. Staj ve iş olanakları.",
            imageSystemName: "briefcase"
        ),
        Event(
            id: "3",
            title: "Yapay Zeka Konferansı",
            date: "22 Mayıs 2025 • 09:00",
            location: "Mühendislik Fakültesi Amfi",
            category: "Teknoloji",
            description: "Makine öğrenmesi ve büyük dil modelleri üzerine akademik konferans.",
            imageSystemName: "cpu"
        ),
        Event(
            id: "4",
            title: "Hackathon 48 Saat",
            date: "24 Mayıs 2025 • 10:00",
            location: "Bilgisayar Mühendisliği Binası",
            category: "Teknoloji",
            description: "48 saatlik kesintisiz kodlama maratonu. Tema: Sürdürülebilir Kampüs.",
            imageSystemName: "laptopcomputer"
        ),
        Event(
            id: "5",
            title: "Açık Hava Sinema Gecesi",
            date: "23 Mayıs 2025 • 20:30",
            location: "Amfi Tiyatro",
            category: "Sinema",
            description: "Yıldızlar altında bağımsız film gösterimleri ve kısa film yarışması finalleri.",
            imageSystemName: "film"
        ),
        Event(
            id: "6",
            title: "Bahar Spor Şenliği",
            date: "17 Mayıs 2025 • 13:00",
            location: "Spor Kompleksi",
            category: "Spor",
            description: "Futbol, basketbol ve voleybol turnuvaları. Bölümler arası rekabet.",
            imageSystemName: "sportscourt"
        )
    ]
}
