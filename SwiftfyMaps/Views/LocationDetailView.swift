import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    Divider()
                    descriptionSection
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading){
            backButton
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        if let location = LocationsDataService.locations.first{
            LocationDetailView(location: location)
                .environmentObject(LocationsViewModel())
        }
    }
}

extension LocationDetailView{
    private var imageSection: some View{
        TabView{
            ForEach(location.imageNames, id: \.self) { image  in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.name)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View{
        VStack(alignment: .leading, spacing: 16){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url  = URL(string: location.link){
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private var mapLayer : some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))),
            annotationItems: [location]){location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1,contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View{
        Button {
            viewModel.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding()
        }

    }

}
