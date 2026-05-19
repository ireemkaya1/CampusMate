import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapVM = MapViewModel()
    @EnvironmentObject private var eventListVM: EventListViewModel
    @State private var selectedEvent: Event?
    
    var body: some View {
        VStack(spacing: 0) {
            Map(
                coordinateRegion: $mapVM.region,
                interactionModes: .all,
                showsUserLocation: true,
                annotationItems: eventListVM.events
            ) { event in
                MapAnnotation(coordinate: event.coordinate) {
                    Button {
                        selectedEvent = event
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.red)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 26, height: 26)
                            )
                            .shadow(radius: 3)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 12) {
                Text("Kampüsteki Etkinlikler")
                    .font(.headline)
                
                if mapVM.isLocationAuthorized {
                    Text("Mavi nokta mevcut konumunu, kırmızı pinler etkinlik konumlarını gösterir. Pine dokunarak etkinlik detayını açabilirsin.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                } else {
                    Text("Konum izni verirsen bulunduğun konuma yakın etkinlikleri daha rahat görebilirsin.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button {
                        mapVM.requestUserLocation()
                    } label: {
                        HStack {
                            Image(systemName: "location.fill")
                            Text("Konumuma İzin Ver")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .navigationTitle("Harita")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedEvent) { event in
            NavigationStack {
                EventDetailView(event: event)
                    .environmentObject(eventListVM)
            }
        }
    }
}
