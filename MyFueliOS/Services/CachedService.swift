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
    private let selectedProductFuelTypeKey = "selectedProductFuelType"
    private let regionCodeKey = "regionCodeKey"
    private let userDefaults = UserDefaults.standard

    //MARK: Favourites
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

    //MARK: Fuel Type / Product selected
    func GetSelectedFuelType() -> Product {
        var rawV = userDefaults.object(forKey: selectedProductFuelTypeKey)
        let product = Product(rawValue: rawV as! Int) as? Product ?? Product.UnleadedPetrol
        return product
    }
    
    func SetSelectedFuelType(type product: Product) {
        userDefaults.setValue(product.rawValue, forKey: selectedProductFuelTypeKey)
    }
    
    
    //MARK: Selected Region
    func GetRegion() -> RegionCode {
        var rawV = userDefaults.object(forKey: regionCodeKey)
        let region = RegionCode(rawValue: rawV as! Int) as? RegionCode ?? RegionCode.Perth
        return region
    }
    
    func SetRegion(region: RegionCode) {
        userDefaults.setValue(region.rawValue, forKey: regionCodeKey)
    }
    
}
