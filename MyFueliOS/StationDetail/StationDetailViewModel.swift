//
//  StationDetailViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/3/21.
//

import Foundation

class StationDetailViewModel: ObservableObject {
    let fuelWatchService : FuelWatchService
    @Published var isLoading: Bool = false;
    @Published var lowestPrice: String = ""
    @Published var highestPrice: String = ""
    @Published var averagePrice: String = ""
    @Published var priceRange: String = ""

    var datePrice = DatePrice.Today {
        didSet {
            fetchStationDetail()
        }
    }
    var product = Product.UnleadedPetrol {
        //similar to @Published to we manually published to reload prices for different products
        didSet {
            fetchStationDetail()
            objectWillChange.send()
        }
    }

    init() {
        self.fuelWatchService = FuelWatchService.shared
        fetchStationDetail()
    }


    func fetchStationDetail()  {
        isLoading = true
        //TODO: fetch perth station tomorrow first,
        //if return empty list meaning before 2:30pm, display empty
        //check if this station is in that list, then use it
        //if station is not in that list, fetch Location/Suburb for tomorrow station
    
        fuelWatchService.getPerthFuel(product: product, datePrice: datePrice) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                   // self.updateDashboardDetails(stations: stations)
                    self.isLoading = false
                }
            }
        }

    }

}


