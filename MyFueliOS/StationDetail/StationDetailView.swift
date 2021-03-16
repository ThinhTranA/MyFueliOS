//
//  StationDetailView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 3/3/21.
//

import SwiftUI
import MapKit

struct StationDetailView: View {
    @State var station: PetrolStation
    @State var hasNavigationBar = true

    var body: some View {
        GeometryReader { geometry in
            VStack{
                if(!hasNavigationBar){
                    Text(station.tradingName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.top)
                }
            
                StationDetailMap(station: station).frame(maxHeight: geometry.size.height * 0.5)
              
                StationDetailPrice(station: station)
                StationDetailOptions(station: station)
                Spacer()
            }.navigationTitle(station.tradingName)
        }
    }
}

struct StationDetailView_Previews: PreviewProvider {

    static var previews: some View {
        StationDetailView(station: PetrolStation.mockPetrolStations[1])
    }
}
