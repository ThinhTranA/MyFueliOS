//
//  StationListViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 17/3/21.
//

import Foundation

class StationListViewModel: ObservableObject {
    let fuelWatchService : FuelWatchService
    
    @Published var nearByStations = [PetrolStation]()
    @Published var perthStations = [PetrolStation]()
    @Published var perthStationsSortedByDistance = [PetrolStation]()
    @Published var product: Product = Product.UnleadedPetrol
    
    init() {
        self.fuelWatchService = FuelWatchService.shared
        fetchPerthPetrolStations()
        
    }
    

    func fetchPetrolStations(near suburb: String)  {
        
        fuelWatchService.getSuburbFuel(product: product, suburb: suburb) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.nearByStations = stations
                }
            }
        }
    }
    
    func fetchPerthPetrolStations()  {
        
        fuelWatchService.getPerthFuel(product: product) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.perthStations = stations.sorted{$0.price < $1.price} //defautl response is always sorted by price, this is just for consistency
                    self.perthStationsSortedByDistance = stations.sorted{$0.distance < $1.distance}
                }
            }
        }
    }
}
