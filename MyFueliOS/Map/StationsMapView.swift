//
//  MapView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationsMapView: View {
    
    @State var petrolList = PetrolStation.mockPetrolStations;
    
    var body: some View {
        MapView(stations: $petrolList)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        StationsMapView()
    }
}
