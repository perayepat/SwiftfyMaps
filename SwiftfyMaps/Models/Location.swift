import Foundation
import CoreLocation

struct Location: Identifiable, Equatable{

    var name: String
    var cityName : String
    var coordinates: CLLocationCoordinate2D
    var description: String
    var imageNames: [String]
    var link: String
    
    /// You might want to have two objects that share the same id and not have them as seperate objects
    var id: String{
        name + cityName
    }
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
