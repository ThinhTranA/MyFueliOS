//
//  MapView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationsMapView: View {
    @ObservedObject var viewModel = StationsMapViewModel()
    @State var selectedPetrolStation: PetrolStation?
    @State var mapFocusToUserLocation = true
    @State var selectedProduct = Product.UnleadedPetrol
    @State var currentRegion = LocationManager.shared.selectedRegionCoordinate

    var body: some View {

        ZStack {
            MapView(stations: $viewModel.perthStations, selectedStation: $selectedPetrolStation, shouldFocusUserLocation: $mapFocusToUserLocation)

            if selectedPetrolStation != nil {
                SelectedStationDetailView(station: $selectedPetrolStation)
            }

            VStack(spacing: 8) {
                fuelTypeSelectionView
                focusToUserLocationButtonView
                Spacer()
            }.padding(EdgeInsets(top: 12, leading: 2, bottom: 0, trailing: 2))

            if (viewModel.isLoading) {
                LoadingView()
            }
        }
        .onAppear{
            viewModel.fetchStations()
            let didChanged = LocationManager.shared.didRegionChanged(regionCoordinate: currentRegion)
            if(didChanged){
                mapFocusToUserLocation = true
            }
        }
    }

    private var fuelTypeSelectionView: some View {
        UIScrollViewWrapper() {
            HStack(spacing: 8) {
                ForEach(Product.allCases, id: \.self) { p in
                    Button(action: {
                        viewModel.product = p
                        viewModel.fetchStations()
                        selectedProduct = p
                    }) {
                        Text(p.description)
                                .fontWeight(.bold)
                                .font(.FjallaOne(size: 14))
                                .padding(8)
                                .background(
                                        p == selectedProduct ? Color.SteamGold : Color.white)
                                .cornerRadius(40)
                                .foregroundColor(.black)
                                .padding(4)
                    }.shadow(color: Color.black.opacity(0.3),
                            radius: 3, x: 3, y: 3)
                }
            }
        }.frame(maxHeight: 60)
    }

    private var focusToUserLocationButtonView: some View {
        HStack {
            Spacer()
            Button(action: {
                mapFocusToUserLocation = true
            }, label: {

                //TODO: this is not working, fix this bug.
                if (mapFocusToUserLocation) {
                    Image(systemName: "location.fill")
                            .font(.system(size: 24))
                            .frame(width: 42, height: 42)
                            .foregroundColor(Color.blue)
                } else {
                    Image(systemName: "location")
                            .font(.system(size: 24))
                            .frame(width: 42, height: 42)
                            .foregroundColor(Color.blue)

                }

            })
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3, x: 3, y: 3)
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        StationsMapView(selectedPetrolStation: PetrolStation.mockPetrolStations[0])
    }
}
