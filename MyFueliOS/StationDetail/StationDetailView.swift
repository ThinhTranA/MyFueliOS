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
    @State var isInFav: Bool = false
    @State var isAddrCopied: Bool = false
    private let favService = CachedService.shared

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                StationDetailMap(station: station).frame(maxHeight: geometry.size.height * 0.4)
                VStack {
                    buttonsList
                    Divider()

                    StationDetailPrice(station: station)

                }.padding()
                Spacer()
            }.navigationTitle(station.tradingName)
        }
    }

    private var buttonsList: some View {
        let btnMaxHeight = CGFloat(40)
        let btnMaxWidth = CGFloat(120)
        let icSize = CGFloat(18)

        return HStack(spacing: 12) {
            Button(action: {
                if (isInFav) {
                    favService.RemoveFromFavourites(station: station)
                } else {
                    favService.AddToFavourites(station: station)
                }
                isInFav.toggle()
            }) {

                HStack(spacing: 4) {
                    Image(systemName: "star")
                            .resizable()
                            .frame(width: icSize, height: icSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(isInFav ? .white : .red)
                    Text(isInFav ? "In Favourite" : "Favourite")
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(isInFav ? .white : .red)
                }

                        .frame(minWidth: 0, maxWidth: btnMaxWidth, minHeight: 28, maxHeight: btnMaxHeight)
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.red, lineWidth: 1.6)
                        )
                        .background(isInFav ? Color.red : Color.white)
                        .cornerRadius(12)
            }.onAppear {
                isInFav = favService.GetFavourites().contains(station.address)
            }

            Button(action: {
                UIPasteboard.general.string = station.address
                isAddrCopied = true
            }) {

                HStack(spacing: 4) {

                    Image(systemName: "doc.on.doc")
                            .resizable()
                            .frame(width: icSize, height: icSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(isAddrCopied ? .white : .green)

                    Text(isAddrCopied ? "Address Copied" : "Address").foregroundColor(isAddrCopied ? .white : .green)
                            .fixedSize(horizontal: false, vertical: true)
                }

                        .frame(minWidth: 0, maxWidth: btnMaxWidth, minHeight: 28, maxHeight: btnMaxHeight)
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.green, lineWidth: 1.6)
                        )
            }.background(isAddrCopied ? Color.green : Color.white)
                    .cornerRadius(12)

            Button(action: {
                let url = URL(string: "http://maps.apple.com/?address=\(station.address.replacingOccurrences(of: " ", with: "+"))")
                if let url = url {
                    UIApplication.shared.open(url)
                }
            }) {

                HStack(spacing: 4) {

                    Image(systemName: "car")
                            .resizable()
                            .frame(width: icSize, height: icSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.SteamGold)
                    Text("Direction").foregroundColor(.SteamGold)
                }.frame(minWidth: 0, maxWidth: btnMaxWidth, minHeight: 28, maxHeight: btnMaxHeight)
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.SteamGold, lineWidth: 1.6)
                        )
            }
        }
    }
}

struct StationDetailView_Previews: PreviewProvider {

    static var previews: some View {
        StationDetailView(station: PetrolStation.mockPetrolStations[1])
    }
}
