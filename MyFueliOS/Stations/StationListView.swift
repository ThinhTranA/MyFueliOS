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
        ZStack {
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        selectFuelTypeView
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        sortButton
                    }
                }
            }.actionSheet(isPresented: $isSortActionSheetPresented) {
                sortActionSheet
            }

            if (viewModel.isLoading) {
                LoadingView()
            }
        }
    }


    private var selectFuelTypeView: some View {
        Menu(content: {
            ForEach(Product.allCases, id: \.self) { p in
                Button(action: {
                    viewModel.fetchPetrolStations(by: p)
                }, label: {
                    Text(p.description)
                })
            }
        }) {
            HStack(spacing: 2) {
                Text(viewModel.product.description)
                        .font(.FjallaOne(size: 16))
                        .fixedSize(horizontal: true, vertical: false)
                Image(systemName: "chevron.down")
            }
        }
    }

    private var sortButton: some View {
        Button(action: {
            self.isSortActionSheetPresented.toggle()
        }, label: {
            Image(systemName: "line.horizontal.3.decrease.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
        })
    }

    private var sortActionSheet: ActionSheet {
        ActionSheet(title: Text("Sort stations by"), buttons: [
            .default(Text("Sort by price")) {
                currentTag = "Price"
            },
            .default(Text("Sort by distance")) {
                currentTag = "Distance"
            },
            .cancel()
        ])
    }
}


struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
    }
}
