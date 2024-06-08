import SwiftUI
import MapKit

@available(iOS 17.0, macOS 14.0, tvOS 16.0, watchOS 9.0, *)
public struct LocationPicker: View {
    @StateObject var viewModel = ViewModel()
    
    @Binding var lat: Double
    @Binding var lon: Double
    
    public init(lat: Binding<Double>, lon: Binding<Double>) {
        self._lat = lat
        self._lon = lon
    }
    
    public var body: some View {
        VStack{
            ZStack{
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onChange(of: viewModel.region.center.latitude) { _, newLat in
                        lat = newLat
                    }
                    .onChange(of: viewModel.region.center.longitude) { _, newLong in
                        lon = newLong
                    }
                
                
                ZStack{
                    Circle()
                        .foregroundColor(.accentColor)
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Image(systemName: "mappin")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Circle()
                        .foregroundColor(.accentColor)
                        .scaledToFit()
                        .frame(width: 7, height: 10)
                        .offset(x: 0, y: 28)
                }
                .shadow(color: .accentColor.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
                .offset(x: 0, y: -28)
            }
            
        }
        .cornerRadius(12)
        .onAppear {
            viewModel.region.center.latitude = lat
            viewModel.region.center.longitude = lon
        }
    }
}

@available(iOS 13.0, *)
class ViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion.london
}

extension MKCoordinateRegion {
    static let london = MKCoordinateRegion(
        center: .init(latitude: 51.05007, longitude: 0),
        latitudinalMeters: 100000,
        longitudinalMeters: 100000
    )
}
