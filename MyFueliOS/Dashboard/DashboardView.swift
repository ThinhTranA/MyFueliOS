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
                    ScrollView {
                    VStack{
                       
                        priceRangeView
                        Spacer()
                        averagePriceView
                        Spacer()
                        cheapestStationsView
                        selectFuelTypeView
                            .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
                    }
                }.navigationTitle("Today")
                    .navigationBarItems(leading:  Text(Date(), style: .date).font(.AmericanCaptain(size: 16)))
            }
        }
    }
    
    
    
    private var priceRangeView: some View {
        Group{
            HStack{
                Text("PERTH PRICE RANGE")
                Spacer()
            }.padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 0))
            
            HStack{
                VStack {
                    Text("Lowest")
                    Text(viewModel.lowestPrice)
                }.padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 0))
                Spacer()
                Image(systemName: "arrow.left")  .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 30)
                Spacer()
                VStack {
                    Text("Range")
                    Text(viewModel.priceRange)
                }
                Spacer()
                Image(systemName: "arrow.right")  .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 30)
                Spacer()
                VStack {
                    Text("Highest")
                    Text(viewModel.highestPrice)
                }.padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 16))
            }
        }
    }
    
    private var averagePriceView: some View {
        Group{
            Text("TODAY'S AVERAGE")
            Text(viewModel.averagePrice)
            Text(viewModel.product.description)
        }
    }
    
    private var cheapestStationsView: some View {
        Group{
            Text("Top 3 cheapest stations")
            VStack {
                ForEach(viewModel.cheapest3Stations) { station in
                    cheapestStationRowView(station: station)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8))
                }
            }
            
            Spacer()
        }
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
    
    private var selectFuelTypeView: some View {
            ZStack{
                Color.white
                HStack{
                    Text("Fuel Type").font(.title3).opacity(0.6)
                    Spacer()
                    Text(viewModel.product.description).font(.title3)
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
