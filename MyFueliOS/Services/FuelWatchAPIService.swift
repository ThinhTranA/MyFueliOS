//
//  FuelWatchAPIService.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 9/3/21.
//

import Foundation
import SwiftyXMLParser

enum Product: Int {
    case UnleadedPetrol = 1
    case PremiumUnleaded = 2
    case Diesel = 4
    case LPG = 5
    case Ron98 = 6
    case E85 = 10
    case BrandDiesel = 11
}


class FuelWatchService {
   static let shared = FuelWatchService()
    
    private let baseAPIURL = "https://www.fuelwatch.wa.gov.au/fuelwatch/fuelWatchRSS"
    //private let urlComponents = URLComponents(string: baseAPIURL)
    private let urlSession = URLSession.shared
    private var stations: [String: [PetrolStation]] = [:]
    
    
    func getSuburbFuel(product: Product, suburb: String, completion: @escaping ([PetrolStation]?) -> ()) {
        //TODO: cache API call if possile, invalidate cache if the day is not valid
        let key = "\(product)\(suburb)"
        if let sts = stations[key] {
            completion(sts)
            return
        }

        let url = URL(string: (baseAPIURL + "?Product=\(product.rawValue)&Suburb=\(suburb)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        var petrolStations = [PetrolStation]()
        
     
        
        let request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
        
            if let returnData = String(data: data, encoding: .utf8) {
                let xml = try! XML.parse(returnData)
                var i = 1
                
                for item in xml["rss"]["channel"]["item"] {
                    let ps = PetrolStation(id: i,
                               title: item["title"].text ?? "",
                               description: item["description"].text ?? "",
                               brand: item["brand"].text ?? "",
                               date: item["date"].text ?? "",
                               price: item["price"].text ?? "",
                               tradingName: item["trading-name"].text ?? "",
                               location: item["location"].text ?? "",
                               address: item["address"].text ?? "",
                               phone: item["phone"].text ?? "",
                               latitude: item["latitude"].text ?? "",
                               longitude: item["longitude"].text ?? "",
                               siteFeatures: item["site-features"].text ?? ""
                    )
                    i += 1
                    petrolStations.append(ps)
                }
                
                self.stations.updateValue(petrolStations, forKey: key)
                
                completion(petrolStations)
             }
            else {
                completion(nil)
            }
                
        })
        
        task.resume()
    }
    
}


