import Foundation
import UserNotifications

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {

    static let shared = NotificationManager()

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    // MARK: - Permission

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Bildirim izni hatası: \(error.localizedDescription)")
            } else {
                print("Bildirim izni durumu: \(granted)")
            }
        }
    }

    // Uygulama açıkken de banner/ses görünsün
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }

    // MARK: - Daily Campus Reminders

    func scheduleDailyCampusReminders() {
        let identifiers = [
            "campusmate-daily-reminder-15",
            "campusmate-daily-reminder-16"
        ]

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)

        scheduleDailyReminder(
            identifier: "campusmate-daily-reminder-15",
            hour: 15,
            minute: 0,
            title: "CampusMate",
            body: "Kampüste bugün neler var? Etkinlikleri kontrol etmeyi unutma."
        )

        scheduleDailyReminder(
            identifier: "campusmate-daily-reminder-16",
            hour: 16,
            minute: 0,
            title: "CampusMate",
            body: "Bugünkü kampüs etkinliklerine göz atmayı unutma."
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.printPendingNotifications()
        }
    }

    private func scheduleDailyReminder(
        identifier: String,
        hour: Int,
        minute: Int,
        title: String,
        body: String
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Günlük bildirim planlanamadı: \(error.localizedDescription)")
            } else {
                print("Günlük bildirim planlandı: \(hour):\(String(format: "%02d", minute))")
            }
        }
    }

    func cancelDailyCampusReminders() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [
                "campusmate-daily-reminder-15",
                "campusmate-daily-reminder-16"
            ]
        )

        print("Günlük CampusMate bildirimleri iptal edildi.")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.printPendingNotifications()
        }
    }

    // MARK: - Event Detail Reminder

    func scheduleCalendarReminder(identifier: String, title: String, body: String, date: Date) {
        guard date > Date() else {
            print("Geçmiş tarihli bildirim planlanmadı: \(identifier)")
            return
        }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Etkinlik bildirimi planlanamadı: \(error.localizedDescription)")
            } else {
                print("Etkinlik bildirimi planlandı: \(identifier)")
                print("Planlanan tarih: \(date)")
            }
        }
    }

    func scheduleDailyEventReminders(eventId: String, eventTitle: String) {
        let identifiers = [
            "\(eventId)-daily-15",
            "\(eventId)-daily-16"
        ]

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)

        scheduleDailyReminder(
            identifier: "\(eventId)-daily-15",
            hour: 15,
            minute: 0,
            title: "CampusMate",
            body: "\(eventTitle) etkinliği için hatırlatma zamanı!"
        )

        scheduleDailyReminder(
            identifier: "\(eventId)-daily-16",
            hour: 16,
            minute: 0,
            title: "CampusMate",
            body: "\(eventTitle) etkinliği için ikinci hatırlatma zamanı!"
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.printPendingNotifications()
        }
    }

    func cancelDailyEventReminders(eventId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [
                "\(eventId)-daily-15",
                "\(eventId)-daily-16"
            ]
        )

        print("Etkinlik günlük bildirimleri iptal edildi: \(eventId)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.printPendingNotifications()
        }
    }

    // MARK: - Test Notifications

    func scheduleTestReminder(eventTitle: String) {
        let content = UNMutableNotificationContent()
        content.title = "CampusMate"
        content.body = "\(eventTitle) için test bildirimi."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: "campusmate-test-\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Test bildirimi planlanamadı: \(error.localizedDescription)")
            } else {
                print("Anlık test bildirimi 5 saniye sonrası için planlandı.")
            }
        }
    }

    func scheduleInstantMockPushNotification() {
        let content = UNMutableNotificationContent()
        content.title = "CampusMate"
        content.body = "Bu bir CampusMate test bildirimidir."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: "mock-push-test-\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Anlık test bildirimi planlanamadı: \(error.localizedDescription)")
            } else {
                print("Anlık test bildirimi 5 saniye sonrası için planlandı.")
            }
        }
    }

    func scheduleMockPushNotification(intervalMinutes: Int) {
        let safeInterval = max(intervalMinutes, 1)
        let seconds = TimeInterval(safeInterval * 60)

        let content = UNMutableNotificationContent()
        content.title = "CampusMate"
        content.body = "Kampüs etkinliklerini kontrol etmeyi unutma."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: seconds,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "mock-push-campusmate",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["mock-push-campusmate"]
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Dakikalık bildirim planlanamadı: \(error.localizedDescription)")
            } else {
                print("Dakikalık bildirim planlandı: Her \(safeInterval) dakikada bir gönderilecek.")
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.printPendingNotifications()
        }
    }

    func cancelMockPushNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["mock-push-campusmate"]
        )

        print("Dakikalık bildirim iptal edildi.")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.printPendingNotifications()
        }
    }

    // MARK: - Clear / Debug

    func clearAllCampusMateNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()

        print("Tüm CampusMate bildirimleri temizlendi.")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.printPendingNotifications()
        }
    }

    func printPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("Bekleyen bildirim sayısı: \(requests.count)")

            for request in requests {
                print("------------------------------")
                print("Bildirim ID: \(request.identifier)")
                print("Başlık: \(request.content.title)")
                print("Mesaj: \(request.content.body)")

                if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                    print("Saat: \(calendarTrigger.dateComponents.hour ?? -1):\(String(format: "%02d", calendarTrigger.dateComponents.minute ?? 0))")
                    print("Tekrar ediyor mu: \(calendarTrigger.repeats)")
                    print("Sonraki tetiklenme zamanı: \(calendarTrigger.nextTriggerDate()?.description ?? "Yok")")
                }

                if let timeTrigger = request.trigger as? UNTimeIntervalNotificationTrigger {
                    print("Time interval: \(timeTrigger.timeInterval)")
                    print("Tekrar ediyor mu: \(timeTrigger.repeats)")
                }
            }
        }
    }
}
