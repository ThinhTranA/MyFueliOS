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
    @Published var isLoading: Bool = false;
    @Published var nearByStations = [PetrolStation]()
    @Published var perthStations = [PetrolStation]()
    @Published var cheapest3Stations = [PetrolStation]()
    @Published var lowestPrice: String = ""
    @Published var highestPrice: String = ""
    @Published var averagePrice: String = ""
    @Published var priceRange: String = ""
    @Published var region = CachedService.shared.GetRegion()

    var datePrice = DatePrice.Today {
        didSet {
            fetchStations()
        }
    }
    var product = CachedService.shared.GetSelectedFuelType() {
        //similar to @Published to we manually published to reload prices for different products
        didSet {
            fetchStations()
            objectWillChange.send()
        }
    }

    init() {
        self.fuelWatchService = FuelWatchService.shared
        fetchStations()
    }

    
    var count: String {
        return String(nearByStations.count)
    }

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
                    self.updateDashboardDetails(stations: stations)
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchSuburbStations(near suburb: String)  {
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
        fuelWatchService.getPerthFuel(product: product, datePrice: datePrice) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.updateDashboardDetails(stations: stations)
                    self.isLoading = false
                }
            }
        }

    }

    private func updateDashboardDetails(stations: [PetrolStation]){
        if(stations.count < 2) {
            let noData = "No Data"
            perthStations = stations
            lowestPrice = noData
            highestPrice = noData
            priceRange = noData
            averagePrice = noData
            cheapest3Stations = Array()
            return
        }
        perthStations = stations
        lowestPrice = (stations.min {Double($0.price) ?? 0 < Double($1.price) ?? 0})!.price
        highestPrice = (stations.min {Double($0.price) ?? 0 > Double($1.price) ?? 0})!.price
        priceRange = String(format: "%.1f" ,Double(self.highestPrice)! - Double(self.lowestPrice)!)
        averagePrice = String(format: "%.1f" , stations.compactMap { Double($0.price) }.reduce(0, +) / Double(stations.count))
        cheapest3Stations = Array( stations.prefix(3)) //default return from FuelWatch order by cheapest price

    }
}

