//
//  StationDetailMap.swift
//  MyFueliOS
//
//  Created by Hung Tran on 8/3/21.
//

import SwiftUI

struct StationDetailMap: View {
    var station : PetrolStation
    var body: some View {
        VStack{
            Text(station.name)
            Color.gray
        }
        //.padding()
        .frame(maxHeight: 400)
    
    }
}

struct StationDetailMap_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailMap(station: PetrolStation.mockPetrolStations[1])
    }
}
