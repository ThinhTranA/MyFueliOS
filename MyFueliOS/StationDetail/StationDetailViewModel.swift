//
//  StationDetailViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/3/21.
//

import Foundation

class StationDetailViewModel: ObservableObject {
    let fuelWatchService = FuelWatchService.shared
    @Published var isLoading: Bool = false;
    @Published var tomorrowPrice = "Price available after 2:30pm"



    func fetchTomorrowPrice(station: PetrolStation) {
        isLoading = true
        let product = station.GetProductType()
        let suburb = station.location

        fuelWatchService.getPerthFuel(product: product, datePrice: DatePrice.Tomorrow) { stations in
            //fetch perth station for tomorrow first
            if let stations = stations {
                if let sta = stations.first(where: {$0.address == station.address}) {
                    DispatchQueue.main.async{
                        self.tomorrowPrice = sta.price
                    }

                    //if station is not in perth list, fetch Location/Suburb for tomorrow station
                } else {

                    self.fuelWatchService.getSuburbFuel(product: product, suburb: suburb){ subStations in
                        if let subStation = subStations?.first(where: {$0.address == station.address}){
                            DispatchQueue.main.async {
                                self.tomorrowPrice = subStation.price
                            }
                        }
                    }
                  
                }
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
        }

    }

}


