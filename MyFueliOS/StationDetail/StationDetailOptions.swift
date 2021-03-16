//
//  StationDetailOptions.swift
//  MyFueliOS
//
//  Created by Hung Tran on 8/3/21.
//

import SwiftUI

struct StationDetailOptions: View {
    @State var station: PetrolStation
    @State private var isFavourite : Bool = false
    
    private let favService = CachedService.shared
    var body: some View {
        VStack(){
            Button(action: {
                if(isFavourite){
                    favService.RemoveFromFavourites(station: station)
                } else {
                    favService.AddToFavourites(station: station)
                }
                
                isFavourite.toggle()
            }){
                HStack{
                    if !isFavourite{
                        Text("Add to Favourites")
                        Spacer()
                        Label("",systemImage: "star")
                    }
                    else{
                        Text("Remove from Favourites")
                        Spacer()
                        Label("",systemImage: "star.slash")
                    }
                }
                .padding()
            }
            
            Button(action:{}){
                HStack{
                    Text("Get directions")
                    Spacer()
                    Label("",systemImage: "car")
                }
                .padding()
            }

        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

struct StationDetailOptions_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailOptions(station: PetrolStation.mockPetrolStations[0])
    }
}
