import SwiftUI

struct WeatherCardView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Kampüs Hava Durumu")
                        .font(.headline)
                    
                    Text(viewModel.conditionText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: viewModel.iconName)
                    .font(.system(size: 34))
                    .foregroundColor(.blue)
            }
            
            HStack(alignment: .bottom, spacing: 8) {
                Text(viewModel.temperatureText)
                    .font(.system(size: 38, weight: .bold))
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Rüzgar")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    if !viewModel.lastUpdatedText.isEmpty {
                        Text(viewModel.lastUpdatedText)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(viewModel.windText)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 4)
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .padding(.horizontal)
    }
}
