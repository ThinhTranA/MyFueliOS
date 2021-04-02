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
                .navigationTitle("\(viewModel.region.text) Stations")
                .alert(isPresented: $viewModel.isLocationDeniedAlert) {
                    Alert(
                            title: Text("Location permission is denied"),
                            message: Text("Failed to calculate distance due to unknown location. Enable location permission in settings."),
                            primaryButton: .default(Text("Ok")) {
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            },
                            secondaryButton: .cancel()
                    )
                }
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

            
            if(!viewModel.isLoading && viewModel.perthStations.count == 0){
                VStack{
                    NoDataErrorView()
                    Button(action: {
                        viewModel.fetchStations()
                    }, label: {
                    HStack(spacing: 10) {
                          Spacer()
                          Text("Try Again ")
                          Image(systemName: "arrow.clockwise.circle")
                              .resizable()
                              .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                          Spacer()
                        }
                      .frame( height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                      .background(Color.SteamGold)
                      .foregroundColor(.white)
                      .cornerRadius(22)
                })
                }.padding()
            }
            
            if (viewModel.isLoading) {
                LoadingView()
            }
            
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Some thing went wrong!"), message: Text("Failed to load data at this time. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .onAppear{
            viewModel.fetchStations()
        }
    }


    private var selectFuelTypeView: some View {
        Menu(content: {
            ForEach(Product.allCases, id: \.self) { p in
                Button(action: {
                    viewModel.product = p
                    viewModel.fetchStations()
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
