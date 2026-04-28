import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var eventListVM: EventListViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Karşılama başlığı
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Merhaba 👋")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        Text("Kampüste neler var?")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Image(systemName: "graduationcap.fill")
                        .font(.title)
                        .foregroundStyle(.blue)
                }

                // Etkinliklere git butonu
                NavigationLink(destination: EventListView()) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Tüm Etkinlikleri Gör")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                // Yaklaşan etkinlikler başlığı
                Text("Yaklaşan Etkinlikler")
                    .font(.headline)

                // Örnek etkinlik kartları
                VStack(spacing: 12) {
                    ForEach(eventListVM.events.prefix(3)) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            HStack(spacing: 14) {
                                Image(systemName: event.imageSystemName)
                                    .font(.title2)
                                    .foregroundStyle(.blue)
                                    .frame(width: 44, height: 44)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(event.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.primary)
                                    Text(event.date)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("CampusMate")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(EventListViewModel())
    .environmentObject(FavoritesViewModel())
}
