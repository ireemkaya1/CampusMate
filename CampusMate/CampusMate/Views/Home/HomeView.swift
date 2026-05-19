import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var eventListVM: EventListViewModel
    @StateObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Üst başlık alanı
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CampusMate")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Merhaba 👋")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text("Kampüste neler var?")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Image(systemName: "graduationcap.fill")
                                .font(.system(size: 34))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 24)
                    
                    // Gerçek API'den gelen hava durumu kartı
                    WeatherCardView(viewModel: weatherVM)
                        .onAppear {
                            weatherVM.fetchWeather()
                        }
                    
                    // Tüm etkinlikleri gör butonu
                    NavigationLink {
                        EventListView()
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                            
                            Text("Tüm Etkinlikleri Gör")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal)
                    
                    // Yaklaşan etkinlikler
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Yaklaşan Etkinlikler")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(Array(eventListVM.events.prefix(3))) { event in
                            NavigationLink {
                                EventDetailView(event: event)
                            } label: {
                                HStack(spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.blue.opacity(0.12))
                                            .frame(width: 52, height: 52)
                                        
                                        Image(systemName: event.imageSystemName)
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(event.title)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                        
                                        Text(event.date)
                                            .font(.caption)
                                            .foregroundColor(.blue.opacity(0.8))
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer(minLength: 80)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
