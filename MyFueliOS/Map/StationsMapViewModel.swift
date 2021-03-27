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

    @Published var isLoading: Bool = false;
    @Published var nearByStations = [PetrolStation]()
    @Published var perthStations = [PetrolStation]()
    
    init() {
        self.fuelWatchService = FuelWatchService.shared
        fetchPerthPetrolStations()
    }
    
    //TODO: Get user preference of petrol type
    var product: Product = Product.UnleadedPetrol
    
    func fetchPetrolStations(near suburb: String)  {
        isLoading = true
        fuelWatchService.getSuburbFuel(product: product, suburb: suburb) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.nearByStations = stations
                    self.isLoading = false
                }
            }
        }
    }

    func fetchPetrolStations(by product: Product){
        isLoading = true
        fuelWatchService.getPerthFuel(product: product) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.perthStations = stations
                    self.product = product
                    self.isLoading = false
                }
            }
        }

        self.product = product
    }
    
    func fetchPerthPetrolStations()  {
        isLoading = true
        fuelWatchService.getPerthFuel(product: product) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.perthStations = stations
                    self.isLoading = false
                }
            }
        }
    }
}
