//
//  StationDetailView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 3/3/21.
//

import SwiftUI
import MapKit

struct StationDetailView: View {
    @ObservedObject var viewModel = StationDetailViewModel()
    @State var station: PetrolStation
    @State private var datePrice = DatePrice.Today
    @State var isInFav: Bool = false
    @State var isAddrCopied: Bool = false
    private let favService = CachedService.shared

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: 0) {
                    StationDetailMap(station: station).frame(maxHeight: geometry.size.height * 0.4)
                    VStack {
                        buttonsList
                        Divider()
                        datePriceSegmentedView
                        stationOverview

                    }.padding()
                    Spacer()
                }.navigationTitle(station.tradingName)
                if(viewModel.isLoading){
                    LoadingView()
                }
            }

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
                    Text(isInFav ? "Saved" : "Favourite")
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(isInFav ? .white : .red)
                }

                        .frame(minWidth: 0, maxWidth: btnMaxWidth, minHeight: 36, maxHeight: btnMaxHeight)
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.red, lineWidth: 1.6)
                        )
                .background(isInFav ? Color.red : Color.clear)
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

                    Text(isAddrCopied ? "Copied" : "Address").foregroundColor(isAddrCopied ? .white : .green)
                            .fixedSize(horizontal: false, vertical: true)
                }

                        .frame(minWidth: 0, maxWidth: btnMaxWidth, minHeight: 28, maxHeight: btnMaxHeight)
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.green, lineWidth: 1.6)
                        )
            }.background(isAddrCopied ? Color.green : Color.clear)
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
    
    
    private var datePriceSegmentedView: some View {
        Picker("DatePrice", selection: $datePrice) {
            ForEach(DatePrice.allCases, id: \.self) { date in
                Text(date.rawValue)
                    .font(.FHACondFrenchNC(size: 18))
                    .tag(date)
            }
        }.pickerStyle(SegmentedPickerStyle())
        .onChange(of: datePrice, perform: { _ in
            viewModel.fetchTomorrowPrice(station: station)
        })
    }
    
    private var stationOverview: some View {
    
        return VStack (spacing: 8) {
        
            HStack(){
                Image(station.logo)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                VStack(spacing: 8) {
                    HStack() {
                        Text("\(station.fuelTypeDescription)")
                            .font(.FjallaOne(size: 17))
                            .opacity(0.8)
                    
                        Spacer()
                        if(datePrice == DatePrice.Today){
                            Text(station.price)
                                    .font(.FjallaOne(size: 25))
                        } else{
                            if(viewModel.tomorrowPrice.count > 10) {
                                Text(viewModel.tomorrowPrice)
                                        .font(.FjallaOne(size: 14))
                                        .opacity(0.5)
                            } else {
                                Text(viewModel.tomorrowPrice)
                                        .font(.FjallaOne(size: 25))
                            }

                        }

                    }
                    HStack() {
                        Text(station.tradingName)
                            .font(.FjallaOne(size: 22))
                        Spacer()
                       
                    }
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(station.distanceString)
                        .font(.FjallaOne(size: 17))
                        Spacer()
                      
                    }
                    .foregroundColor(Color("SecondTextColor"))
                }.padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
            
            }
            
            Divider()
            
            HStack {
                if(datePrice == DatePrice.Today){
                    Text("Today,")
                    Text(Date(), style: .date)
                } else {
                    Text("Tomorrow,")
                    Text(Date().addingTimeInterval(86400), style: .date)
                }

                Spacer()
            }  .font(.FjallaOne(size: 17))
            .opacity(0.8)
            
            HStack() {
                Text("Address: \(station.address), \(station.location)")
                    .font(.FjallaOne(size: 17))
                    .opacity(0.8)
                Spacer()
                
            }
            
            HStack() {
                Text("Phone: \(station.phone)")
                    .font(.FjallaOne(size: 17))
                    .opacity(0.8)
                
                
                Spacer()
                
            }
        }
            }
}

struct StationDetailView_Previews: PreviewProvider {

    static var previews: some View {
        StationDetailView(station: PetrolStation.mockPetrolStations[1]).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
