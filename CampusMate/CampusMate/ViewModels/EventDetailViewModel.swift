import Foundation
import Combine
import UserNotifications

final class EventDetailViewModel: ObservableObject {
    let event: Event

    @Published var isNotificationScheduled = false

    init(event: Event) {
        self.event = event
    }

    func toggleNotification() {
        let baseIdentifier = "event-date-reminder-\(event.id)"

        if isNotificationScheduled {
            UNUserNotificationCenter.current().removePendingNotificationRequests(
                withIdentifiers: [
                    "\(baseIdentifier)-1day",
                    "\(baseIdentifier)-1hour",
                    "\(baseIdentifier)-event-time"
                ]
            )

            isNotificationScheduled = false
            print("Etkinlik hatırlatması iptal edildi.")

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationManager.shared.printPendingNotifications()
            }

        } else {
            guard let eventDate = parseEventDate(from: event.date) else {
                print("Etkinlik tarihi okunamadı: \(event.date)")
                return
            }

            let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: eventDate)
            let oneHourBefore = Calendar.current.date(byAdding: .hour, value: -1, to: eventDate)

            var plannedCount = 0

            if let oneDayBefore = oneDayBefore, oneDayBefore > Date() {
                NotificationManager.shared.scheduleCalendarReminder(
                    identifier: "\(baseIdentifier)-1day",
                    title: "CampusMate",
                    body: "\(event.title) etkinliği yarın gerçekleşecek. Etkinliği kaçırma!",
                    date: oneDayBefore
                )

                plannedCount += 1
            }

            if let oneHourBefore = oneHourBefore, oneHourBefore > Date() {
                NotificationManager.shared.scheduleCalendarReminder(
                    identifier: "\(baseIdentifier)-1hour",
                    title: "CampusMate",
                    body: "\(event.title) etkinliği 1 saat sonra başlayacak.",
                    date: oneHourBefore
                )

                plannedCount += 1
            }

            if plannedCount == 0, eventDate > Date() {
                NotificationManager.shared.scheduleCalendarReminder(
                    identifier: "\(baseIdentifier)-event-time",
                    title: "CampusMate",
                    body: "\(event.title) etkinliği başlamak üzere.",
                    date: eventDate
                )
            }

            isNotificationScheduled = true

            print("Etkinlik hatırlatması planlandı.")
            print("Etkinlik tarihi: \(eventDate)")
            print("Hatırlatma: 1 gün önce ve 1 saat önce")

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationManager.shared.printPendingNotifications()
            }
        }
    }

    private func parseEventDate(from dateString: String) -> Date? {
        // Beklenen örnek format:
        // "25 Mayıs 2026 - 14:00"

        let parts = dateString.components(separatedBy: " - ")

        guard parts.count == 2 else {
            return nil
        }

        let datePart = parts[0]
        let timePart = parts[1]

        let dateComponents = datePart.split(separator: " ")
        let timeComponents = timePart.split(separator: ":")

        guard dateComponents.count == 3,
              timeComponents.count == 2,
              let day = Int(dateComponents[0]),
              let year = Int(dateComponents[2]),
              let hour = Int(timeComponents[0]),
              let minute = Int(timeComponents[1]) else {
            return nil
        }

        let monthName = String(dateComponents[1]).lowercased()

        let months: [String: Int] = [
            "ocak": 1,
            "şubat": 2,
            "mart": 3,
            "nisan": 4,
            "mayıs": 5,
            "haziran": 6,
            "temmuz": 7,
            "ağustos": 8,
            "eylül": 9,
            "ekim": 10,
            "kasım": 11,
            "aralık": 12
        ]

        guard let month = months[monthName] else {
            return nil
        }

        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute

        return Calendar.current.date(from: components)
    }
}
