//
//  DashboardView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 9/3/21.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @ObservedObject var locationManager = LocationManager()
    init() {
        self.viewModel = DashboardViewModel()
    }

    var body: some View {
        NavigationView {
                ZStack {
                    Color.gray.opacity(0.1).ignoresSafeArea()
                    //TODO: Fix Navigation title stop working in the scroll view
                    // Top 3 cheapst station distance in km text is cut off on iphone Xs, not happening on simulator though.
                    ScrollView {
                        VStack (spacing: 8){
                       
                        priceRangeView
                        Spacer()
                        averagePriceView
                        Spacer()
                        cheapestStationsView
                    
                    } .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                }.navigationTitle("Today")
                    .navigationBarItems(leading:  Text(Date(), style: .date).font(.AmericanCaptain(size: 16)).opacity(0.5))
            }
        }
    }
    
    
    
    private var priceRangeView: some View {
        VStack (spacing: 16){
            HStack{
                Text("Perth price range").font(.FjallaOne(size: 22))
                Spacer()
            }
            
            HStack(spacing: 16) {
                VStack(spacing: 8) {
                    Text("Lowest").font(.FjallaOne(size: 14))
                    Text(viewModel.lowestPrice).font(.FjallaOne(size: 17))
                }
                Path { path in
                    path.move(to: CGPoint(x: 80, y: 4.82))
                    path.addLine(to: CGPoint(x: 11.02, y: 4.99))
                    path.addLine(to: CGPoint(x: 6.91, y: 5))
                    path.addLine(to: CGPoint(x: 6.91, y: -0))
                    path.addLine(to: CGPoint(x: 0, y: 8))
                    path.addLine(to: CGPoint(x: 6.91, y: 16))
                    path.addLine(to: CGPoint(x: 6.91, y: 11))
                    path.addLine(to: CGPoint(x: 80, y: 10.64))
                    path.addLine(to: CGPoint(x: 80, y: 4.82))
                                 
                }
                .fill(Color.SteamGold)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 8))
  
                VStack(spacing: 8) {
                    Text("Range").font(.FjallaOne(size: 14))
                    Text(viewModel.priceRange).font(.FjallaOne(size: 17))
                }
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 4.82))
                    path.addLine(to: CGPoint(x: 68.98, y: 4.99))
                    path.addLine(to: CGPoint(x: 73.09, y: 5))
                    path.addLine(to: CGPoint(x: 73.09, y: -0))
                    path.addLine(to: CGPoint(x: 80, y: 8))
                    path.addLine(to: CGPoint(x: 73.09, y: 16))
                    path.addLine(to: CGPoint(x: 73.09, y: 11))
                    path.addLine(to: CGPoint(x: 0, y: 10.64))
                    path.addLine(to: CGPoint(x: 0, y: 4.82))
                                 
                }.fill(Color.SteamGold)
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 0))

                VStack(spacing: 8) {
                    Text("Highest").font(.FjallaOne(size: 14))
                    Text(viewModel.highestPrice).font(.FjallaOne(size: 17))
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private var averagePriceView: some View {
        VStack (spacing: 8){
            HStack{
                Text("Today's average").font(.FjallaOne(size: 22))
                Spacer()
            }
            Text(viewModel.averagePrice).font(.FjallaOne(size: 28))
            Text(viewModel.product.description).font(.FjallaOne(size: 17))
        }
        .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private var cheapestStationsView: some View {
        VStack{
            HStack{
                Text("Top 3 cheapest stations").font(.FjallaOne(size: 22))
                Spacer()
            }
            VStack {
                ForEach(viewModel.cheapest3Stations) { station in
                    cheapestStationRowView(station: station)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8))
                }
            }
            
            Spacer()
        } .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private func cheapestStationRowView(station: PetrolStation) -> some View {
        HStack{
            Text(station.price)
            Spacer()
            Image(station.logo)
                .resizable()
                .frame(width: 50, height: 50, alignment: .leading)
            Spacer()
            Text(station.tradingName).frame(width:150, alignment: .leading)
            Spacer()
            VStack{
                Image(systemName: "mappin.and.ellipse")
                Text(station.distanceString)
            }
        }
    }
    
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
