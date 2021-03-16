//
//  DashboardView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 9/3/21.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var dashboardVM: DashboardViewModel
    @ObservedObject var locationManager = LocationManager()
    init() {
        self.dashboardVM = DashboardViewModel()
    }

    var body: some View {
        VStack{
            if(dashboardVM.isLoading){
                ProgressView().onReceive(locationManager.$suburb){ suburb in
                    if let suburb = suburb {
                        dashboardVM.fetchPetrolStations(near: suburb)
                    }
                }
            }
//            TextField("Suburb", text: $dashboardVM.suburb)
//            Button(action: {
//              //  dashboardVM.fetchPetrolStations()
//            }) {
//                Text("Load fuel")
//            }
            
           Text("Stations count:\(dashboardVM.count)")
           Text("First station on the list:")
            Text("Perth \(dashboardVM.product.description) price range")
            Text("Lowest price: \(dashboardVM.lowestPrice)")
            Text("Highest price: \(dashboardVM.highestPrice)")
            Text("Price range: \(dashboardVM.priceRange)")
            if(dashboardVM.nearByStations.count > 0){
                Text(dashboardVM.nearByStations[0].brand)
                Text(dashboardVM.nearByStations[0].address)
                Text("Price:")
                Text(dashboardVM.nearByStations[0].price)
            }
            
            if(dashboardVM.perthStations.count > 0) {
                Text("Perth stations count:\(dashboardVM.perthStations.count)")
            }
 
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
