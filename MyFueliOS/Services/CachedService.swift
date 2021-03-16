//
//  FavouriteService.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 16/3/21.
//

import Foundation

class CachedService {
    static let shared = CachedService()
    
    private let favouriteListKey = "favouriteStations"
    private let selectedProductFuelType = "selectedProductFuelType"
    private let userDefaults = UserDefaults.standard
    
    func AddToFavourites(station: PetrolStation){
        print("\(station.tradingName) added to favourte")
        
        var favList: [String] = userDefaults.object(forKey: favouriteListKey) as? [String] ?? []
        favList.append(station.address)
        userDefaults.set(favList, forKey: favouriteListKey)
        
    }
    
    func RemoveFromFavourites(station: PetrolStation) {
        var favList: [String] = userDefaults.object(forKey: favouriteListKey) as? [String] ?? []
        if favList.count == 0 {
            return
        }
        
        favList.removeAll{$0 == station.address}
        userDefaults.set(favList, forKey: favouriteListKey)
    }
    
    func GetFavourites() -> [String]{
        let favList: [String] = userDefaults.object(forKey: favouriteListKey) as? [String] ?? []
        return favList
    }
    
    func GetSelectedFuelType() -> Product {
        let product = userDefaults.object(forKey: selectedProductFuelType) as? Product ?? Product.UnleadedPetrol
        return product
    }
    
    func SetSelectedFuelType(type product: Product) {
        userDefaults.setValue(product, forKey: selectedProductFuelType)
    }
    
}
