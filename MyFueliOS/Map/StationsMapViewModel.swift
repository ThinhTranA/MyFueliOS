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
    @Published var hasError: Bool = false;
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
                self.handleSuccessRequest(stations: stations)
            } else {
                self.handleOnFailure()
            }
        }
    }
    
    func fetchPerthPetrolStations()  {
        isLoading = true
        fuelWatchService.getPerthFuel(product: product) { stations in
            if let stations = stations {
                self.handleSuccessRequest(stations: stations)
            } else {
                self.handleOnFailure()
            }
        }
    }
    
    private func handleOnFailure(){
        DispatchQueue.main.async {
            self.isLoading = false
            self.hasError = true
        }
    }
    
    private func handleSuccessRequest(stations: [PetrolStation]){
        DispatchQueue.main.async {
            self.perthStations = stations
            self.isLoading = false
        }
    }
}
