//
//  StationsView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationListView: View {
    var petrolList = PetrolStation.mockPetrolStations;
    var body: some View {
        List(petrolList, id: \.id) { station in
            StationRowView(petrolStation: station)
        }
    }
}

struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
