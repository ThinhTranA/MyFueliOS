//
//  FavouriteScreenView.swift
//  MyFueliOS
//
//  Created by Hung Tran on 12/3/21.
//

import SwiftUI

struct FavouriteScreenView: View {
    var body: some View {
        NavigationView {
                List {
                    VStack {
                        Text("Favourite here")
                          }

            }.navigationTitle("Favourites")
        }
    }
}

struct FavouriteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteScreenView()
    }
}
