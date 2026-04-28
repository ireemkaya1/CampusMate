import SwiftUI

struct EventListView: View {
    @EnvironmentObject private var eventListVM: EventListViewModel
    @State private var searchText = ""

    private var filteredEvents: [Event] {
        guard !searchText.isEmpty else { return eventListVM.events }
        return eventListVM.events.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.category.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Arama alanı (TextField)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Etkinlik veya kategori ara...", text: $searchText)
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(10)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .padding(.vertical, 8)

            // Etkinlik listesi (List)
            if filteredEvents.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("Etkinlik bulunamadı.")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(filteredEvents) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        EventRowView(event: event)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Etkinlikler")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EventListView()
    }
    .environmentObject(EventListViewModel())
    .environmentObject(FavoritesViewModel())
}
