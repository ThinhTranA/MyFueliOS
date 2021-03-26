//
//  StationRowView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 2/3/21.
//

import SwiftUI

struct StationRowView: View {
    var petrolStation: PetrolStation

    var body: some View {
        HStack(){
            Image(petrolStation.logo)
                .resizable()
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            VStack(spacing: 3) {
                HStack() {
                    Text(petrolStation.tradingName)
                        .font(.FjallaOne(size: 17))
                    Spacer()
                    Text(petrolStation.price)
                        .font(.FjallaOne(size: 22))
                }
                
                HStack() {
                    Text(petrolStation.address)
                        .font(.FjallaOne(size: 14))
                    Spacer()
                    Text(petrolStation.fuelType)
                        .font(.FjallaOne(size: 14))
                    
                }
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(petrolStation.distanceString)
                    .font(.FjallaOne(size: 14))
                    Spacer()
                    Text("Today").font(.FjallaOne(size: 17))
                }
                .font(.footnote)
                .foregroundColor(Color("SecondTextColor"))
            }.padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
        
        }
        
       
    }

}

struct StationRowView_Previews: PreviewProvider {
    static var previews: some View {
        StationRowView(petrolStation: PetrolStation.mockPetrolStations[0])
    }
}



