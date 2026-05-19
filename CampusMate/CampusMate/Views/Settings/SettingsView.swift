
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @State private var showClearConfirmation = false
    @State private var feedbackMessage = ""
    
    var body: some View {
        List {
            
            // Bildirim ayarları
            Section("Bildirimler") {
                Toggle(isOn: $notificationsEnabled) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundStyle(.orange)
                        
                        Text("Etkinlik Bildirimleri")
                    }
                }
                .onChange(of: notificationsEnabled) { _, newValue in
                    if newValue {
                        NotificationManager.shared.requestPermission()
                        showFeedback("Bildirim izni kontrol edildi.")
                    } else {
                        NotificationManager.shared.cancelAllCampusMateNotifications()
                        showFeedback("Bildirimler kapatıldı.")
                    }
                }
            }
            
            // Push bildirimi simülasyonu
            Section("Bildirim Kontrolleri") {
                Button {
                    NotificationManager.shared.scheduleMockPushNotification(intervalMinutes: 60)
                    NotificationManager.shared.printPendingNotifications()
                    showFeedback("Saatlik etkinlik bildirimi başlatıldı.")
                } label: {
                    SettingsActionRow(
                        icon: "clock",
                        title: "Saatlik Bildirim Başlat",
                        color: .blue
                    )
                }
                .buttonStyle(PressableSettingsButtonStyle())
                
                Button {
                    NotificationManager.shared.scheduleMockPushNotification(intervalMinutes: 1)
                    NotificationManager.shared.printPendingNotifications()
                    showFeedback("Dakikalık test bildirimi başlatıldı.")
                } label: {
                    SettingsActionRow(
                        icon: "timer",
                        title: "Dakikalık Test Bildirimi",
                        color: .orange
                    )
                }
                .buttonStyle(PressableSettingsButtonStyle())
                
                Button {
                    NotificationManager.shared.scheduleInstantMockPushNotification()
                    showFeedback("Anlık test bildirimi gönderiliyor.")
                } label: {
                    SettingsActionRow(
                        icon: "paperplane.fill",
                        title: "Anlık Test Bildirimi Gönder",
                        color: .green
                    )
                }
                .buttonStyle(PressableSettingsButtonStyle())
                
                Button(role: .destructive) {
                    NotificationManager.shared.cancelMockPushNotification()
                    NotificationManager.shared.cancelAllCampusMateNotifications()
                    NotificationManager.shared.printPendingNotifications()
                    showFeedback("Tüm bildirimler durduruldu.")
                } label: {
                    SettingsActionRow(
                        icon: "bell.slash",
                        title: "Tüm Bildirimleri Durdur",
                        color: .red
                    )
                }
                .buttonStyle(PressableSettingsButtonStyle())
                
                if !feedbackMessage.isEmpty {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        
                        Text(feedbackMessage)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            
            // Favoriler
            Section("Favoriler") {
                NavigationLink {
                    FavoritesView()
                } label: {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        
                        Text("Kayıtlı Favori")
                        
                        Spacer()
                        
                        Text("\(favoritesVM.favoriteIDs.count)")
                            .foregroundStyle(.secondary)
                    }
                }
                Button(role: .destructive) {
                    showClearConfirmation = true
                } label: {
                    SettingsActionRow(
                        icon: "trash",
                        title: "Tüm Favorileri Temizle",
                        color: .red
                    )
                }
                .buttonStyle(PressableSettingsButtonStyle())
                .disabled(favoritesVM.favoriteIDs.isEmpty)
                .confirmationDialog(
                    "Tüm favoriler silinecek.",
                    isPresented: $showClearConfirmation,
                    titleVisibility: .visible
                ) {
                    Button("Temizle", role: .destructive) {
                        favoritesVM.clearAll()
                        showFeedback("Tüm favoriler temizlendi.")
                    }
                    
                    Button("İptal", role: .cancel) { }
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
            }
        }
        .navigationTitle("Ayarlar")
    }
    
    private func showFeedback(_ message: String) {
        feedbackMessage = message
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if feedbackMessage == message {
                feedbackMessage = ""
            }
        }
    }
}

struct SettingsActionRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 24)
            
            Text(title)
                .foregroundStyle(.primary)
            
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct PressableSettingsButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.55 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(FavoritesViewModel())
    }
}
