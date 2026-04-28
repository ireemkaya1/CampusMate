import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            appTabView
        } else {
            splashContent
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        isActive = true
                    }
                }
        }
    }

    // MARK: - Splash Ekranı

    private var splashContent: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.white)

                Text("CampusMate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text("Kampüsünü Keşfet")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
    }

    // MARK: - Ana Sekme Görünümü

    private var appTabView: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Ana Sayfa", systemImage: "house.fill")
            }

            NavigationStack {
                MapView()
            }
            .tabItem {
                Label("Harita", systemImage: "map.fill")
            }

            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favoriler", systemImage: "heart.fill")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Ayarlar", systemImage: "gearshape.fill")
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(EventListViewModel())
        .environmentObject(FavoritesViewModel())
}
