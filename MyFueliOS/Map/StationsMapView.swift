//
//  MapView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct StationsMapView: View {
    @ObservedObject var dashboardVM = StationsMapViewModel()
    @State var selectedPetrolStation: PetrolStation?
    @State var mapFocusToUserLocation = true
    @State var selectedProduct = Product.UnleadedPetrol

    
    var body: some View {
        
        ZStack {
            MapView(stations: $dashboardVM.perthStations, selectedStation: $selectedPetrolStation, shouldFocusUserLocation: $mapFocusToUserLocation)
            
            if selectedPetrolStation != nil {
                VStack{
                    Spacer()
                    SelectedStationDetailView(station: Binding($selectedPetrolStation)!)
                }
            }

            HStack {
               // Spacer()
                VStack(spacing: 24){
                    //TODO: fix the picker is not selectable
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(Product.allCases, id: \.self) { p in
                                Button(action: {
                                    dashboardVM.fetchPetrolStations(by: p)
                                    //TODO only update this if success
                                    selectedProduct = p
                                }){
                                    Text(p.description)
                                        .fontWeight(.bold)
                                        .font(.FjallaOne(size: 14))
                                        .padding(8)
                                        .background(
                                            p == selectedProduct ? Color.SteamGold : Color.white)
                                        .cornerRadius(40)
                                        .foregroundColor(.black)
                                        .padding(4)
                                }

                            }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            mapFocusToUserLocation = true
                        }, label: {
                            
                            //TODO: this is not working, fix this bug.
                            if( mapFocusToUserLocation){
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
                            radius: 3, x: 3,y: 3)
                    }
                    
                   
                    
                    Spacer()
                }
            }.padding()
          
            //TODO: add button to re focus map back go current user location
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        StationsMapView( selectedPetrolStation: PetrolStation.mockPetrolStations[0])
    }
}
