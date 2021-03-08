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

            VStack() {
                //Text(petrolStation.logo)
                HStack() {
                    Text(petrolStation.location)
                    Spacer()
                    Text(petrolStation.price)
                }
                
                HStack() {
                    Text(petrolStation.address)
                    Spacer()
                }
            }
        
        }
        
       
    }

}

struct StationRowView_Previews: PreviewProvider {
    static var previews: some View {
        StationRowView(petrolStation: PetrolStation.mockPetrolStations[0])
    }
}



