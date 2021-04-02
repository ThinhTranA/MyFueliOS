//
//  SettingsViewModel.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 21/3/21.
//

import Foundation
class SettingsViewModel: ObservableObject {
    private let fuelWatchService = FuelWatchService.shared
    private let cachedService = CachedService.shared
    var region = RegionCode.Perth {
        didSet {
            cachedService.SetRegion(region: region)

            LocationManager.shared.lookupGPSFromLocationName()

            objectWillChange.send()
        }
    }

    var product = Product.UnleadedPetrol {
        didSet {
            cachedService.SetSelectedFuelType(type: product)
            objectWillChange.send()
        }
    }
    
    init(){
        loadSettings()
    }

    func loadSettings() {
        product = cachedService.GetSelectedFuelType();
        region = cachedService.GetRegion();
    }
}
