//
//  StationListViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 17/3/21.
//

import Foundation
import CoreLocation

class StationListViewModel: ObservableObject {
    private let fuelWatchService = FuelWatchService.shared

    @Published var isLoading: Bool = false;
    @Published var hasError: Bool = false;
    @Published var isLocationDeniedAlert: Bool = false;
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
    
    private func handleOnFailure(){
        DispatchQueue.main.async {
            self.isLoading = false
            self.hasError = true
        }
    }
    
    private func handleSuccessRequest(stations: [PetrolStation]){
        DispatchQueue.main.async {
            self.perthStations = stations.sorted{$0.price < $1.price}
            //defautl response is always sorted by price, this is just for consistency
            if(stations.count > 0 && stations[0].distance != nil){
                self.perthStationsSortedByDistance = stations.sorted{$0.distance! < $1.distance!}
            } else {
                self.perthStationsSortedByDistance = self.perthStations
            }
            self.isLoading = false


            if(LocationManager.shared.locationStatus == CLAuthorizationStatus.denied){
                self.isLocationDeniedAlert = true
            }
        }

    }
}
