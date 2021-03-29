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
        //TODO: fetch perth station tomorrow first,
        //if return empty list meaning before 2:30pm, display empty
        //check if this station is in that list, then use it
        //if station is not in that list, fetch Location/Suburb for tomorrow station

        fuelWatchService.getPerthFuel(product: station.GetProductType(), datePrice: DatePrice.Tomorrow) { stations in
            if let stations = stations {
                if let sta = stations.first {$0.address == station.address} {

                }
            }
        }

    }

}


