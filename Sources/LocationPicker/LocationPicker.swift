import SwiftUI
import MapKit

@available(iOS 17.0, macOS 14.0, tvOS 16.0, watchOS 9.0, *)
public struct LocationPicker: View {
    
    @Binding var lat: Double
    @Binding var lon: Double
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005))
    }
    
    public init(lat: Binding<Double>, lon: Binding<Double>) {
        self._lat = lat
        self._lon = lon
    }

    public var body: some View {
        VStack{
            ZStack{

                Map(coordinateRegion: .constant(region),
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onChange(of: region.center.latitude) { _, newLat in
                        lat = newLat
                    }
                    .onChange(of: region.center.longitude) { _, newLong in
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
    }
}
