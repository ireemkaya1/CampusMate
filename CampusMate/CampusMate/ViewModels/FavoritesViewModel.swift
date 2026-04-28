import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteIDs: Set<String> = []

    func toggle(_ event: Event) {
        // TODO: UserDefaults ile kalıcı depolama ekle
        if favoriteIDs.contains(event.id) {
            favoriteIDs.remove(event.id)
        } else {
            favoriteIDs.insert(event.id)
        }
    }

    func isFavorite(_ event: Event) -> Bool {
        favoriteIDs.contains(event.id)
    }

    func clearAll() {
        // TODO: UserDefaults temizleme ekle
        favoriteIDs.removeAll()
    }
}
