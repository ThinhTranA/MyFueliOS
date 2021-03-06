//
//  MapView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationsMapView: View {
    
    @State var petrolList = PetrolStation.mockPetrolStations;
    @State var selectedPetrolStation: PetrolStation?
    
    var body: some View {
        
        ZStack {
            MapView(stations: $petrolList, selectedStation: $selectedPetrolStation)
            
            if selectedPetrolStation != nil {
                VStack{
                    Spacer()
                    SelectedStationDetailView(station: Binding($selectedPetrolStation)!)
                }
            }
         
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        StationsMapView(petrolList: PetrolStation.mockPetrolStations, selectedPetrolStation: PetrolStation.mockPetrolStations[0])
    }
}
