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
    @Published var lowestPrice: String = ""
    @Published var highestPrice: String = ""
    @Published var priceRange: String = ""
    @Published var product: Product = Product.UnleadedPetrol
    
    init() {
        self.fuelWatchService = FuelWatchService.shared
        fetchPerthPetrolStations()
    }
    
    var isLoading: Bool = true;
    
    var count: String {
        return String(nearByStations.count)
    }
    
    
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
                    self.lowestPrice = (stations.min {$0.price < $1.price})!.price
                    self.highestPrice = (stations.min {$0.price > $1.price})!.price
                    self.priceRange = String(format: "%.1f" ,Double(self.highestPrice)! - Double(self.lowestPrice)!)
                }
            }
            self.isLoading = false
        }
    }
}
