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
    
    @Published var nearByStations = [PetrolStation]()
    @Published var perthStations = [PetrolStation]()
    
    init() {
        self.fuelWatchService = FuelWatchService.shared
        fetchPerthPetrolStations()
    }
    
    var isLoading: Bool = true;
    
    var count: String {
        return String(nearByStations.count)
    }
    
    //TODO: Get user preference of petrol type
    var product: Product = Product.UnleadedPetrol
    
    func fetchPetrolStations(near suburb: String)  {
        
        fuelWatchService.getSuburbFuel(product: product, suburb: suburb) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.nearByStations = stations
                }
            }
            self.isLoading = false
        }
    }
    
    func fetchPerthPetrolStations()  {
        
        fuelWatchService.getPerthFuel(product: product) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.perthStations = stations
                }
            }
            self.isLoading = false
        }
    }
}
