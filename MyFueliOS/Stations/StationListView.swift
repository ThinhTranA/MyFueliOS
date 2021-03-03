//
//  StationsView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationListView: View {
    var petrolList = PetrolStation.mockPetrolStations;
    @State private var searchText : String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                SegmentedControl()
                List {
                    
                    ForEach(petrolList, id: \.id){ station in
                            StationRowView(petrolStation: station)
                        }
                }
            }.navigationTitle("Petrol Stations")
        }
    }
}

struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
