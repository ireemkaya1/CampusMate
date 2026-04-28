import SwiftUI

struct EventRowView: View {
    let event: Event
    @EnvironmentObject private var favoritesVM: FavoritesViewModel

    var body: some View {
        HStack(spacing: 14) {
            // Etkinlik ikonu
            Image(systemName: event.imageSystemName)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 48, height: 48)
                .background(Color.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            // Etkinlik bilgileri
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)

                Text(event.date)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: 4) {
                    Image(systemName: "mappin")
                        .font(.caption2)
                    Text(event.location)
                        .font(.caption)
                        .lineLimit(1)
                }
                .foregroundStyle(.secondary)
            }

            Spacer()

            // Favori göstergesi
            if favoritesVM.isFavorite(event) {
                Image(systemName: "heart.fill")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 4)
    }
}
