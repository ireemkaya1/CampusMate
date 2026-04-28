import SwiftUI

// TODO: MapKit entegrasyonu burada yapılacak.
// Eklenecekler: import MapKit, Map view, Annotation, CLLocationManager
//
// Location izni için Xcode proje ayarlarına eklenmesi gereken key:
// NSLocationWhenInUseUsageDescription

struct MapView: View {
    @StateObject private var mapVM = MapViewModel()
    @EnvironmentObject private var eventListVM: EventListViewModel

    var body: some View {
        ZStack {
            // TODO: Map(position: $cameraPosition) { ... } buraya gelecek
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "map.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.blue)

                Text("Kampüs Haritası")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Harita entegrasyonu yakında aktif olacak.\n\(eventListVM.events.count) etkinlik gösterilecek.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button {
                    mapVM.requestLocation()
                } label: {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Konumuma İzin Ver")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("Harita")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
    .environmentObject(EventListViewModel())
}
