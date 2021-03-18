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
        
        ZStack {
            Color.gray.opacity(0.1)
            VStack{
                HStack{
                    Text("PERTH PRICE RANGE")
                    Spacer()
                }.padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 0))
         
                PriceRangeView(lowest: viewModel.lowestPrice, highest: viewModel.highestPrice, range: viewModel.priceRange)
                
                Spacer()
                AveragePriceView(averagePrice: viewModel.averagePrice, description: viewModel.product.description)
               
                Spacer()
           
                Group{
                    Text("Top 3 cheapest stations")
                    VStack {
                        ForEach(viewModel.cheapest3Stations) { station in
                            CheapestStationRowView(station: station)
                                .padding(EdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8))
                        }
                    }
                    
                    Spacer()
                }
                          
                SelectFuelTypeView(fuelType: viewModel.product.description)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
            }
           
        }
        
    }
}

struct CheapestStationRowView: View {
    var station : PetrolStation
    var body: some View {
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

struct AveragePriceView: View {
    var averagePrice: String
    var description: String
    var body: some View {
        Text("TODAY'S AVERAGE")
        Text(averagePrice)
        Text(description)
    }
}

struct PriceRangeView: View {
    var lowest: String
    var highest: String
    var range: String
    var body: some View {
        HStack{
            VStack {
                Text("Lowest")
                Text(lowest)
            }.padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 0))
            Spacer()
            Image(systemName: "arrow.left")  .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 30)
            Spacer()
            VStack {
                Text("Range")
                Text(range)
            }
            Spacer()
            Image(systemName: "arrow.right")  .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 30)
            Spacer()
            VStack {
                Text("Highest")
                Text(highest)
            }.padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 16))
        }
    }
}

struct SelectFuelTypeView: View {
    var fuelType: String
    var body: some View{
        ZStack{
            Color.white
            HStack{
                Text("Fuel Type").font(.title3).opacity(0.6)
                Spacer()
                Text(fuelType).font(.title3)
                Image(systemName: "chevron.right")
            }.padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        }.frame( height: 60, alignment: .center)
        .cornerRadius(20)
   
    .onTapGesture {
        print("change fuel type tapped")
    }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
