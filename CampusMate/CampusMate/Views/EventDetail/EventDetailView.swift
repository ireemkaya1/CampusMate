import SwiftUI

struct EventDetailView: View {
    let event: Event
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @StateObject private var viewModel: EventDetailViewModel

    init(event: Event) {
        self.event = event
        _viewModel = StateObject(wrappedValue: EventDetailViewModel(event: event))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Etkinlik ikonu (hero alanı)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue.opacity(0.1))
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                    Image(systemName: event.imageSystemName)
                        .font(.system(size: 64))
                        .foregroundStyle(.blue)
                }

                // Kategori etiketi
                Text(event.category)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .foregroundStyle(.blue)
                    .clipShape(Capsule())

                // Başlık
                Text(event.title)
                    .font(.title2)
                    .fontWeight(.bold)

                // Bilgi satırları
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                            .frame(width: 20)
                        Text(event.date)
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack(spacing: 10) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundStyle(.red)
                            .frame(width: 20)
                        Text(event.location)
                            .font(.subheadline)
                        Spacer()
                    }
                }

                Divider()

                // Açıklama
                VStack(alignment: .leading, spacing: 8) {
                    Text("Etkinlik Hakkında")
                        .font(.headline)
                    Text(event.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                Divider()

                // Aksiyon butonları
                VStack(spacing: 12) {
                    // Favori butonu
                    Button {
                        favoritesVM.toggle(event)
                    } label: {
                        HStack {
                            Image(systemName: favoritesVM.isFavorite(event) ? "heart.fill" : "heart")
                            Text(favoritesVM.isFavorite(event) ? "Favorilerden Çıkar" : "Favorilere Ekle")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(favoritesVM.isFavorite(event) ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                        .foregroundStyle(favoritesVM.isFavorite(event) ? .red : .primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    // Bildirim butonu
                    Button {
                        viewModel.toggleNotification()
                    } label: {
                        HStack {
                            Image(systemName: viewModel.isNotificationScheduled ? "bell.slash" : "bell")
                            Text(viewModel.isNotificationScheduled ? "Hatırlatmayı İptal Et" : "Beni Hatırlat")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .foregroundStyle(.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .padding()
        }
        .navigationTitle(event.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EventDetailView(event: Event.samples[0])
    }
    .environmentObject(FavoritesViewModel())
}
