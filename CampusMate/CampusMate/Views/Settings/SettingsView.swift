import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @State private var notificationsEnabled = false
    @State private var showClearConfirmation = false

    var body: some View {
        List {
            // Bildirim toggle
            Section("Bildirimler") {
                Toggle(isOn: $notificationsEnabled) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundStyle(.orange)
                        Text("Etkinlik Bildirimleri")
                    }
                }
                // TODO: UNUserNotificationCenter ile bağla
            }

            // Favoriler
            Section("Favoriler") {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                    Text("Kayıtlı Favori")
                    Spacer()
                    Text("\(favoritesVM.favoriteIDs.count)")
                        .foregroundStyle(.secondary)
                }

                Button(role: .destructive) {
                    showClearConfirmation = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Tüm Favorileri Temizle")
                    }
                }
                .disabled(favoritesVM.favoriteIDs.isEmpty)
                .confirmationDialog(
                    "Tüm favoriler silinecek.",
                    isPresented: $showClearConfirmation,
                    titleVisibility: .visible
                ) {
                    Button("Temizle", role: .destructive) { favoritesVM.clearAll() }
                    Button("İptal", role: .cancel) {}
                }
            }

            // Uygulama bilgisi
            Section("Hakkında") {
                HStack {
                    Text("Uygulama")
                    Spacer()
                    Text("CampusMate")
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Versiyon")
                    Spacer()
                    Text("1.0")
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Kampüs")
                    Spacer()
                    Text("ODTÜ Demo")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Ayarlar")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environmentObject(FavoritesViewModel())
}
