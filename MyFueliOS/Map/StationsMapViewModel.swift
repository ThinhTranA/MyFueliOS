//
//  StationsMapViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 14/3/21.
//

import Foundation


import Combine
import Foundation
import SwiftUI

class StationsMapViewModel: ObservableObject {
    let fuelWatchService : FuelWatchService
    
    @Published var nearByStations = [PetrolStation]()
    @Published var perthStations = [PetrolStation]()
    
    init() {
        self.fuelWatchService = FuelWatchService.shared
        fetchPerthPetrolStations()
    }
    
    var isLoading: Bool = true;
    
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

    func fetchPetrolStations(by product: Product){
        fuelWatchService.getPerthFuel(product: product) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.perthStations = stations
                    self.product = product
                }
            }
        }

        self.product = product
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
