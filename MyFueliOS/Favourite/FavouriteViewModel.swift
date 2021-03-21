//
//  FavouriteViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 16/3/21.
//

import Foundation

class FavouriteViewModel: ObservableObject {
    private let fuelWatchService = FuelWatchService.shared
    private let cachedService = CachedService.shared
    
    @Published var favStations = [PetrolStation]()
    
    init() {
    }
    
    var isLoading: Bool = true;
    
    func fetchFavouriteStations()  {
        fuelWatchService.getPerthFuel(product: cachedService.GetSelectedFuelType()) { stations in
            if let stations = stations {
                print("favourited stations \(self.cachedService.GetFavourites())")
                let favs = self.cachedService.GetFavourites()
                var favouriteStations = [PetrolStation]()
                favs.forEach { fa in
                    let sta = stations.first {$0.address == fa}
                    if let sta = sta {
                        favouriteStations.append(sta)
                    }
                }
                DispatchQueue.main.async {
                    self.favStations = favouriteStations
                }
            }
            self.isLoading = false
        }
    }
}