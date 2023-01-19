import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations : [Location]
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationsList: Bool = false
    
    init(){
        let locations = LocationsDataService.locations
        self.locations  = locations
        ///gurad let here
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
     func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed(){
        // get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Next button pressed has an error")
            return
        }

        //check if we're at the end of our array
        let nextIndex =  currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        
        //next index
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
