//
//  FuelWatchAPIService.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 9/3/21.
//

import Foundation
import SwiftyXMLParser


enum DatePrice: String, CaseIterable {
    case Today
    case Tomorrow
}


class FuelWatchService {
   static let shared = FuelWatchService()
    
    private let baseAPIURL = "https://www.fuelwatch.wa.gov.au/fuelwatch/fuelWatchRSS"
    //private let urlComponents = URLComponents(string: baseAPIURL)
    private let urlSession = URLSession.shared
    private var stations: [String: [PetrolStation]] = [:]
    
   
    
    func getSuburbFuel(product: Product, suburb: String, datePrice: DatePrice = DatePrice.Today, completion: @escaping ([PetrolStation]?) -> ()) {
        let key = "\(product)\(suburb)\(datePrice.rawValue)"

        var query = "?Product=\(product.rawValue)"
        if (datePrice == DatePrice.Tomorrow){
            query = "?Product=\(product.rawValue)&Day=tomorrow"
        }
        let url = URL(string: (baseAPIURL + query).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        getFuelStations(key: key, urlWithQuery: url!, product: product, completion: completion)
    }
    
    
    func getPerthFuel(product: Product, datePrice: DatePrice = DatePrice.Today, completion: @escaping ([PetrolStation]?) -> ()) {
        let key = "\(product)PerthRegion\(datePrice.rawValue)"

        var query = "?Product=\(product.rawValue)"
        if (datePrice == DatePrice.Tomorrow){
            query = "?Product=\(product.rawValue)&Day=tomorrow"
        }
        let url = URL(string: (baseAPIURL + query).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        getFuelStations(key: key, urlWithQuery: url!, product: product, completion: completion)
    }

    private func getFuelStations(key : String, urlWithQuery url: URL, product: Product, completion: @escaping ([PetrolStation]?) -> ()) {
        //look in memory cache first
        if let sts = stations[key] {
            completion(sts)
            return
        }

        var petrolStations = [PetrolStation]()

        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let returnData = String(data: data, encoding: .utf8) {
                let xml = try! XML.parse(returnData)
                var i = 1

                for item in xml["rss"]["channel"]["item"] {
                    let ps = self.parseStation(stationXML: item, id: i, product: product)
                    i += 1
                    petrolStations.append(ps)
                }
                //save in memory cache
                self.stations.updateValue(petrolStations, forKey: key)

                completion(petrolStations)
            }
            else {
                completion(nil)
            }

        })

        task.resume()
    }

    private func parseStation(stationXML item : XML.Accessor, id: Int, product: Product) -> PetrolStation {
        PetrolStation(id: id,
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
                siteFeatures: item["site-features"].text ?? "",
                fuelType: product.shortDescription,
                fuelTypeDescription: product.description
        )
    }
}


