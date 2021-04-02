//
//  FavouriteEmptyViewHolder.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 3/4/21.
//

import SwiftUI

struct FavouriteEmptyViewHolder: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                    VStack {
                        Text("Add station to your favourite list by tapping Favourite button")
                            .multilineTextAlignment(.leading)
                            .font(.FjallaOne(size: 17))
                            .padding()
                        Image("AddToFavouriteGuide")
                            .resizable()
                            .frame(width: 280, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.1), lineWidth: 1.6)
                            )
                    }.padding()
                    .background(Color.CardBackground)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.3),
                                   radius: 5, x: 3,y: -3)
                   
                    VStack {
                        Text("A saved favourite station will only be shown if selected fuel type is available at that station.")
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .font(.FjallaOne(size: 17))
                            .padding()
                        Image("SelectedFuelTypeGuide")
                            .resizable()
                            .frame(width: 280, height: 280, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.1), lineWidth: 1.6)
                            )
                    }.padding()
                    .background(Color.CardBackground)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.3),
                                   radius: 5, x: 3,y: -3)
            }.padding()
        }
   
    }
}

struct FavouriteEmptyViewHolder_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEmptyViewHolder().preferredColorScheme(.dark)
    }
}
