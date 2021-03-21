//
//  FavouriteScreen.swift
//  MyFueliOS
//
//  Created by Hung Tran on 13/3/21.
//

import SwiftUI

struct FavouriteView: View {
    @ObservedObject var viewModel = FavouriteViewModel()
    @State private var currentTag = "Price"
    var body: some View {
        NavigationView {
                List {
                    ForEach(viewModel.favStations){ station in
                        NavigationLink (destination: StationDetailView(station: station)) {
                            StationRowView(petrolStation: station)
                    }
            }   
        }.onAppear{
            viewModel.fetchFavouriteStations()
        }.navigationTitle("Favourites")
    }
}
}
struct FavouriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
