import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var viewModel : LocationsViewModel
    let maxIpadWidth: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
    
            VStack(spacing: 0){
                header
                    .padding()
                    .frame(maxWidth: maxIpadWidth)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $viewModel.sheetLocation,onDismiss: nil) { location in
            LocationDetailView( location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView{
    private var header: some View{
        VStack{
            Button { viewModel.toggleLocationsList()
            } label: {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .cityTitle()
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                    }
            }

            if viewModel.showLocationsList{
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 15)
        .padding()
        
    }
    
    private var mapLayer : some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            interactionModes: .all,
            annotationItems: $viewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates.wrappedValue) {
                LocationMapAnnotationView()
                    .scaleEffect(viewModel.mapLocation == location.wrappedValue ? 1 : 0.7)
                    .shadow(radius: 5)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location.wrappedValue)
                    }
            }
        }
          )
    }
    
    private var locationsPreviewStack: some View {
        ZStack{
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location{
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxIpadWidth)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}
