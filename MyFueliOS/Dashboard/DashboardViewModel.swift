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
    @Published var cheapest3Stations = [PetrolStation]()
    @Published var lowestPrice: String = ""
    @Published var highestPrice: String = ""
    @Published var averagePrice: String = ""
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
    
    func fetchPerthPetrolStations(datePrice: DatePrice = DatePrice.Today)  {
        
        fuelWatchService.getPerthFuel(product: product, datePrice: datePrice) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.updateDashboardDetails(stations: stations)
                }
            }
            self.isLoading = false
        }

    }

    private func updateDashboardDetails(stations: [PetrolStation]){
        perthStations = stations
        lowestPrice = (stations.min {$0.price < $1.price})!.price
        highestPrice = (stations.min {$0.price > $1.price})!.price
        priceRange = String(format: "%.1f" ,Double(self.highestPrice)! - Double(self.lowestPrice)!)
        averagePrice = String(format: "%.1f" , stations.compactMap { Double($0.price) }.reduce(0, +) / Double(stations.count))
        cheapest3Stations = Array( stations.prefix(3)) //default return from FuelWatch order by cheapest price

    }
}

