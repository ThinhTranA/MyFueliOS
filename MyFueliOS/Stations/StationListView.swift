//
//  StationsView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationListView: View {
    @StateObject var viewModel = StationListViewModel()
    @State private var searchText: String = ""
    @State private var currentTag = "Price"
    @State private var isSortActionSheetPresented = false

    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $searchText, placeholder: "Search all stations")

                ForEach((currentTag == "Price" ? viewModel.perthStations : viewModel.perthStationsSortedByDistance).filter {
                    self.searchText.isEmpty ? true : $0.tradingName.lowercased().contains(self.searchText.lowercased())
                }) { station in

                    NavigationLink(destination: StationDetailView(station: station)) {
                        StationRowView(petrolStation: station)
                    }
                }

            }
            .listStyle(PlainListStyle())
             .navigationTitle("Petrol Stations")
            //   .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                  self.isSortActionSheetPresented.toggle()
            }, label: {
                Text("Unleaded")
                //TODO: do the picker/popover in of the tutorial.
            }),
                trailing: Button(action: {
                  self.isSortActionSheetPresented.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3.decrease.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
            })
            
            )
        
     
        }.actionSheet(isPresented: $isSortActionSheetPresented) {
            ActionSheet( title: Text("Sort stations by"), buttons: [
                .default(Text("Sort by price")) {currentTag = "Price"},
                .default(Text("Sort by distance")) {currentTag = "Distance"},
                .cancel()
            ])
        }
    }


}


struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
