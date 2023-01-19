import Foundation
import SwiftUI

struct CityTitle: ViewModifier{
    
    func body(content: Content) -> some View {
        
        content
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
    }
}

extension View{
    func cityTitle() -> some View{
        modifier(CityTitle())
    }
}
