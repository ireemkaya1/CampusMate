import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    private let favoritesKey = "campusmate.favoriteIDs"

    @Published var favoriteIDs: Set<String> = [] {
        didSet {
            saveFavorites()
        }
    }

    init() {
        loadFavorites()
    }

    func toggle(_ event: Event) {
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
        favoriteIDs.removeAll()
    }

    private func saveFavorites() {
        let array = Array(favoriteIDs)
        UserDefaults.standard.set(array, forKey: favoritesKey)
    }

    private func loadFavorites() {
        let savedArray = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        favoriteIDs = Set(savedArray)
    }
    
}
