import SwiftUI
import EventKit
import EventKitUI

struct CalendarEventEditView: UIViewControllerRepresentable {
    let event: Event
    
    private let eventStore = EKEventStore()
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let viewController = EKEventEditViewController()
        viewController.eventStore = eventStore
        viewController.editViewDelegate = context.coordinator
        
        let calendarEvent = EKEvent(eventStore: eventStore)
        calendarEvent.title = event.title
        calendarEvent.location = event.location
        calendarEvent.notes = event.description
        
        let startDate = parseEventDate(from: event.date) ?? Date().addingTimeInterval(3600)
        calendarEvent.startDate = startDate
        calendarEvent.endDate = startDate.addingTimeInterval(2 * 60 * 60)
        
        if let defaultCalendar = eventStore.defaultCalendarForNewEvents {
            calendarEvent.calendar = defaultCalendar
        }
        
        viewController.event = calendarEvent
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, EKEventEditViewDelegate {
        func eventEditViewController(
            _ controller: EKEventEditViewController,
            didCompleteWith action: EKEventEditViewAction
        ) {
            controller.dismiss(animated: true)
        }
    }
    
    private func parseEventDate(from text: String) -> Date? {
        // Beklenen format:
        // "25 Mayıs 2026 - 14:00"
        
        let parts = text.components(separatedBy: " - ")
        guard parts.count == 2 else { return nil }
        
        let datePart = parts[0]
        let timePart = parts[1]
        
        let dateComponents = datePart.components(separatedBy: " ")
        guard dateComponents.count == 3 else { return nil }
        
        guard let day = Int(dateComponents[0]) else { return nil }
        let monthText = dateComponents[1].lowercased()
        guard let year = Int(dateComponents[2]) else { return nil }
        
        let timeComponents = timePart.components(separatedBy: ":")
        guard timeComponents.count == 2 else { return nil }
        
        guard let hour = Int(timeComponents[0]),
              let minute = Int(timeComponents[1]) else {
            return nil
        }
        
        let monthMap: [String: Int] = [
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
        
        guard let month = monthMap[monthText] else { return nil }
        
        var components = DateComponents()
        components.calendar = Calendar.current
        components.timeZone = TimeZone.current
        components.day = day
        components.month = month
        components.year = year
        components.hour = hour
        components.minute = minute
        
        return components.date
    }
}
