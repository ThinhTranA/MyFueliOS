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
    
    @Published var perthStations = [PetrolStation]()
    
    init() {
    }
    
    var isLoading: Bool = true;
    
    func fetchFavouriteStations()  {
        
        fuelWatchService.getPerthFuel(product: cachedService.GetSelectedFuelType()) { stations in
            if let stations = stations {
                DispatchQueue.main.async {
                    self.perthStations = stations
                    print("favourited stations \(self.cachedService.GetFavourites())")
                }
            }
            self.isLoading = false
        }
    }
}
