//
//  StationsView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationListView: View {
    @StateObject var viewModel = StationListViewModel()
    @State private var searchText : String = ""
    @State private var currentTag = "Price"

    var body: some View {
        NavigationView {
                List {
                    SearchBar(text: $searchText, placeholder: "Search all stations")
                    VStack {
                        Picker(selection: $currentTag, label: Text("Sort by price or by distance")) {
                                  Text("Price").tag("Price")
                                  Text("Distance").tag("Distance")
                              }
                              .pickerStyle(SegmentedPickerStyle())
                        
                    }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    ForEach((currentTag == "Price" ? viewModel.perthStations : viewModel.perthStationsSortedByDistance).filter{
                        self.searchText.isEmpty ? true : $0.tradingName.lowercased().contains(self.searchText.lowercased())
                    }){ station in
                       
                        NavigationLink (destination: StationDetailView(station: station)) {
                            StationRowView(petrolStation: station)
                    }
                }

            }.navigationTitle("Petrol Stations")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
  
    
}


struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
