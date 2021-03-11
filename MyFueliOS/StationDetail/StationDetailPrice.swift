//
//  StationDetailPrice.swift
//  MyFueliOS
//
//  Created by Hung Tran on 8/3/21.
//

import SwiftUI

struct StationDetailPrice: View {
    var station: PetrolStation
    var body: some View {
        VStack(){
            HStack{
                Text("E91")
                Spacer()
                Text(station.price)
            }
            .padding()
        }
    }
}

struct StationDetailPrice_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailPrice(station: PetrolStation.mockPetrolStations[1])
    }
}
