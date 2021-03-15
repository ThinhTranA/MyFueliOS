//
//  StationDetailView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 3/3/21.
//

import SwiftUI
import MapKit

struct StationDetailView: View {
    @State var station: PetrolStation

    var body: some View {
        VStack{
            Text(station.name)
            StationDetailMap(station: station).frame(maxHeight: 300)
            Spacer()
            StationDetailPrice(station: station)
            StationDetailOptions()
        }
    }
}

struct StationDetailView_Previews: PreviewProvider {

    static var previews: some View {
        StationDetailView(station: PetrolStation.mockPetrolStations[1])
    }
}
