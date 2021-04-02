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
    let fuelWatchService = FuelWatchService.shared

    @Published var isLoading: Bool = false;
    @Published var nearByStations = [PetrolStation]()
    @Published var perthStations = [PetrolStation]()
    @Published var region = CachedService.shared.GetRegion()
    @Published var product = CachedService.shared.GetSelectedFuelType()

    func fetchStations(){
         region = CachedService.shared.GetRegion()
        if(region == RegionCode.Perth){
            fetchPerthPetrolStations()
        } else {
            fetchRegionStations(region: region)
        }
    }
    
    func fetchRegionStations(region: RegionCode)  {
        isLoading = true
        fuelWatchService.getRegionFuel(product: product, region: region){ stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.updateModels(stations: stations)
                }
            }
        }
    }
    
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
                    self.updateModels(stations: stations)
                }
            }
        }
    }
    
    private func updateModels(stations: [PetrolStation]){
        self.perthStations = stations
        self.isLoading = false
    }
}
