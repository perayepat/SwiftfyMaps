import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var viewModel : LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                    .padding()
                Spacer()
                ZStack{
                    ForEach(viewModel.locations) { location in
                        if viewModel.mapLocation == location{
                            LocationPreviewView(location: location)
                                .shadow(color: .black.opacity(0.3), radius: 20)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                }
            }
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
}
