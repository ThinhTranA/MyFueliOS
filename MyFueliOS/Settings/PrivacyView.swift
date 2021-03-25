//
// Created by Thinh Tran on 25/3/21.
//

import Foundation
import SwiftUI

struct PrivacyView: View {

    var body: some View {
       VStack{
           Text("Location").font(.title2)
           Text("Fuel Lens request your location to determine nearby petrol stations to you. Fuel Lens app does not store your location data")
           Text("App preferences and settings").font(.title2)
           Text("Your app preferences, favorites and settings are store on your device and not being sent anywhere else.")
       }

    }

}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
