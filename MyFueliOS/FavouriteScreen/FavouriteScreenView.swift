//
//  FavouriteScreen.swift
//  MyFueliOS
//
//  Created by Hung Tran on 13/3/21.
//

import SwiftUI

struct FavouriteScreenView: View {
    @State private var currentTag = "Price"
    var body: some View {
        NavigationView {
                List {
                    VStack {
                              Picker(selection: $currentTag, label: Text("Sort by price or by distance")) {
                                  Text("Price").tag("Price")
                                  Text("Distance").tag("Distance")
                              }
                              .pickerStyle(SegmentedPickerStyle())

                        
                          }


            }.navigationTitle("Favourites")
        }
    }
}

struct FavouriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteScreenView()
    }
}
