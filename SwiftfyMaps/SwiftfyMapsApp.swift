import SwiftUI

@main
struct SwiftfyMapsApp: App {
    
    @StateObject private var viewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ///Any thing in this view will have refrence to this environment
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
