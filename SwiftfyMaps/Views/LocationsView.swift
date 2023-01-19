import SwiftUI
import MapKit

struct LocationsView: View {

    @EnvironmentObject private var viewModel : LocationsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.locations){ city in
                Text(city.cityName)
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
