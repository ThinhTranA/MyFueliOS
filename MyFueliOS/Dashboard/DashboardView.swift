//
//  DashboardView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 9/3/21.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var dashboardVM: DashboardViewModel
    init() {
        self.dashboardVM = DashboardViewModel()
    }

    var body: some View {
        VStack{
            if(dashboardVM.isLoading){
                ProgressView()
            }
            TextField("Suburb", text: $dashboardVM.suburb)
            Button(action: {
                dashboardVM.fetchPetrolStations()
            }) {
                Text("Load fuel")
            }
            
           Text("Stations count:\(dashboardVM.count)")
           Text("First station on the list:")
            if(dashboardVM.stations.count > 0){
                Text(dashboardVM.stations[0].brand)
                Text(dashboardVM.stations[0].address)
                Text("Price:")
                Text(dashboardVM.stations[0].price)
            }
 
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
