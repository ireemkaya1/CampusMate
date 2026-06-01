
import SwiftUI

@main
struct CampusMateApp: App {
    @StateObject private var eventListVM = EventListViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(eventListVM)
                .environmentObject(favoritesVM)
                .onAppear {
                    NotificationManager.shared.requestPermission()
                }
        }
    }
}
