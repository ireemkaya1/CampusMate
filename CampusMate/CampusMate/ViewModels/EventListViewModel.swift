import Foundation

final class EventListViewModel: ObservableObject {
    @Published var events: [Event] = Event.samples
    @Published var isLoading = false

    private let service = EventService()

    func fetchEvents() async {
        // TODO: Gerçek API çağrısı ile değiştir
        isLoading = true
        events = await service.fetchEvents()
        isLoading = false
    }
}
