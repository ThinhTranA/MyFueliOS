//
//  StationsObsevedObject.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 9/3/21.
//

import Combine
import Foundation
import SwiftUI

class DashboardViewModel: ObservableObject {
    let fuelWatchService : FuelWatchService
    
    @Published var stations = [PetrolStation]()
   
    
    init() {
        self.fuelWatchService = FuelWatchService.shared
     
    }
    
    var isLoading: Bool = true;
    
    var count: String {
        return String(stations.count)
    }
    
//    var location: object {
//        return locationManager.$lastLocation
//    }

    var product: Product = Product.UnleadedPetrol
    
    func fetchPetrolStations(suburb: String)  {
        
        fuelWatchService.getSuburbFuel(product: product, suburb: suburb) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.stations = stations
                }
            }
            self.isLoading = false
        }
    }
}
