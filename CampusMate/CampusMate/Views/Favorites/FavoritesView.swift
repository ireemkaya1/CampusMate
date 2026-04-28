import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @EnvironmentObject private var eventListVM: EventListViewModel

    private var favoriteEvents: [Event] {
        eventListVM.events.filter { favoritesVM.isFavorite($0) }
    }

    var body: some View {
        VStack {
            if favoriteEvents.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 56))
                        .foregroundStyle(.secondary)

                    Text("Favori Etkinlik Yok")
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text("Etkinlik detayından\n\"Favorilere Ekle\" butonuna basın.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(favoriteEvents) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            EventRowView(event: event)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { favoritesVM.toggle(favoriteEvents[$0]) }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favoriler")
        .toolbar {
            if !favoriteEvents.isEmpty {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
    }
    .environmentObject(FavoritesViewModel())
    .environmentObject(EventListViewModel())
}
