//
//  MapView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationsMapView: View {
    
    @State var petrolList = PetrolStation.mockPetrolStations;
    @State private var selectedPetrolStation: PetrolStation?
    
    var body: some View {
        
        ZStack {
            MapView(stations: $petrolList, selectedStation: $selectedPetrolStation)
            
            Text(selectedPetrolStation?.title ?? "no selected station")
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        StationsMapView()
    }
}
