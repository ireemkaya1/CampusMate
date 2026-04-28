import Foundation

final class EventDetailViewModel: ObservableObject {
    let event: Event
    @Published var isNotificationScheduled = false

    init(event: Event) {
        self.event = event
    }

    func toggleNotification() {
        // TODO: NotificationService entegrasyonu
        isNotificationScheduled.toggle()
    }
}
