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
    @State private var currentTag = "Price"
    //var currentSortList = [PetrolStation]()
    
    var body: some View {
        NavigationView {
                List {
                    VStack {
                              Picker(selection: $currentTag, label: Text("Sort by price or by distance")) {
                                  Text("Price").tag("Price")
                                  Text("Distance").tag("Distance")
                              }
                              .pickerStyle(SegmentedPickerStyle())
                          }
                    ForEach(setList(tag: currentTag, list: petrolList), id: \.id){ station in
                        NavigationLink (destination: StationDetailView(station: station)) {
                            StationRowView(petrolStation: station)
                    }
                }

            }.navigationTitle("Petrol Stations")
        }
    }
    
    func setList(tag: String, list: [PetrolStation]) -> [PetrolStation]{
        if tag == "Price"{
            return list.sorted{ $0.price < $1.price}
        }
        else{
            return list.sorted{$0.distance < $1.distance}
        }
    }
    
}


struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
