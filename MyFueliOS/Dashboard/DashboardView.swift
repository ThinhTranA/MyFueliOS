//
//  DashboardView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 9/3/21.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var datePrice = DatePrice.Today
    init() {
        self.viewModel = DashboardViewModel()
    }
  
    var body: some View {
        ZStack{
            NavigationView {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                ScrollView {
                    VStack (spacing: 8){
                        datePriceSegmentedView
                        Spacer()
                        
                        if(viewModel.perthStations.count < 2 && datePrice == DatePrice.Tomorrow){
                            tomorrowPriceEmptyView
                            Spacer()
                        }
                        else {
                            priceRangeView
                            Spacer()
                            averagePriceView
                            Spacer()
                            cheapestStationsView
                        }
                    } .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                }
            }.navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    fuelTypePickerView
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    dateTextView
                }
            }
        }
            if(viewModel.isLoading){
                LoadingView()
            }
        }
        .onAppear{
            viewModel.fetchStations()
        }

    }

    private var fuelTypePickerView: some View {
        Menu(content: {
            ForEach(Product.allCases, id: \.self) { p in
                Button(action: {
                    viewModel.product = p
                }, label: {
                    Text(p.description)
                })
            }
        }) {
            HStack(spacing:2) {
                Text(viewModel.product.description)
                        .font(.FjallaOne(size: 16))
                    .fixedSize(horizontal: true, vertical: false)
                Image(systemName: "chevron.down")
            }
        }
    }

    private var dateTextView: some View {
        switch datePrice {
        case .Today:
               return Text(Date(), style: .date).font(.AmericanCaptain(size: 16)).opacity(0.5)
        case .Tomorrow:
               return Text(Date().addingTimeInterval(86400), style: .date).font(.AmericanCaptain(size: 16)).opacity(0.5)
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
            viewModel.datePrice = datePrice
        })
    }
    
    private var priceRangeView: some View {
        VStack (spacing: 16){
            HStack{
                Text("\(viewModel.region.text) price range").font(.FjallaOne(size: 22))
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
                Text("\(datePrice.rawValue)'s average").font(.FjallaOne(size: 22))
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
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                }
            }
            
            Spacer()
        } .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private func cheapestStationRowView(station: PetrolStation) -> some View {
        HStack{
            Image(station.logo)
                .resizable()
                .frame(width: 50, height: 48, alignment: .leading)
            VStack {
                HStack {
                    Text(station.price).font(.FjallaOne(size: 17))
                    Spacer()
                }
                HStack {
                    Text(station.tradingName).font(.FjallaOne(size: 14))
                        .foregroundColor(Color.black.opacity(0.8))
                    Spacer()
                }
            }
          
            Spacer()
            VStack(spacing: 8){
                Image(systemName: "mappin.and.ellipse")
                Text(station.distanceString).font(.FjallaOne(size: 14))
                    .foregroundColor(Color.black.opacity(0.8))
            }
        }
    }
    
    private var tomorrowPriceEmptyView: some View {
        Text("Tomorrow Prices are only available after 2:30PM")
            .font(.FjallaOne(size: 18))
            .opacity(0.5)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 32, leading: 24, bottom: 0, trailing: 24))
    }
    
}


struct StationRowView1:  View {
    var station = PetrolStation.mockPetrolStations[0]
    var body: some View {
        HStack{
            Image(station.logo)
                .resizable()
                .frame(width: 50, height: 50, alignment: .leading)
            VStack {
                HStack {
                    Text(station.price).font(.FjallaOne(size: 17))
                    Spacer()
                }
                HStack {
                    Text(station.tradingName).font(.FjallaOne(size: 14))
                        .foregroundColor(Color.black.opacity(0.8))
                    Spacer()
                }
            }
          
            Spacer()
            VStack(spacing: 8){
                Image(systemName: "mappin.and.ellipse")
                Text(station.distanceString).font(.FjallaOne(size: 17))
            }
        }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DashboardView()
            StationRowView1()
        }
    }
}
