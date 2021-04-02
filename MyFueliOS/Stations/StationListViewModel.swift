//
//  StationListViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 17/3/21.
//

import Foundation

class StationListViewModel: ObservableObject {
    private let fuelWatchService = FuelWatchService.shared

    @Published var isLoading: Bool = false;
    @Published var nearByStations = [PetrolStation]()
    @Published var perthStations = [PetrolStation]()
    @Published var perthStationsSortedByDistance = [PetrolStation]()
    @Published var product: Product = CachedService.shared.GetSelectedFuelType()
    @Published var region = CachedService.shared.GetRegion()
    
    func fetchStations(){
         region = CachedService.shared.GetRegion()
        if(region == RegionCode.Perth){
            fetchPerthPetrolStations()
        } else {
            fetchRegionStations(region: region)
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
    
    private func updateModels(stations: [PetrolStation]){
        self.perthStations = stations.sorted{$0.price < $1.price}
        //defautl response is always sorted by price, this is just for consistency
        if(stations.count > 0 && stations[0].distance != nil){
            self.perthStationsSortedByDistance = stations.sorted{$0.distance! < $1.distance!}
        } else {
            self.perthStationsSortedByDistance = self.perthStations
        }
        self.isLoading = false
    }
}
