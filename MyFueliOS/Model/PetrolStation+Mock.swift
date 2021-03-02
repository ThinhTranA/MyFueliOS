//
//  PetrolStation+Stub.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 2/3/21.
//

import Foundation
import SwiftyXMLParser

extension PetrolStation {
    static var mockPetrolStations: [PetrolStation] {
        var petrolStations = [PetrolStation]()
        if let path = Bundle.main.path(forResource: "fuelWatchRSS", ofType: "xml") {
            do {
                let contents = try String(contentsOfFile: path)
                let xml = try! XML.parse(contents)
                
                for item in xml["rss"]["channel"]["item"] {
                    let ps = PetrolStation(id: 1,
                               title: item["title"].text ?? "",
                               description: item["description"].text ?? "",
                               brand: item["brand"].text ?? "",
                               date: item["date"].text ?? "",
                               price: item["price"].text ?? "",
                               tradingName: item["tradingName"].text ?? "",
                               location: item["location"].text ?? "",
                               address: item["address"].text ?? "",
                               phone: item["phone"].text ?? "",
                               latitude: item["latitude"].text ?? "",
                               longitude: item["longitude"].text ?? "",
                               siteFeatures: item["siteFeatures"].text ?? ""
                    )
                    petrolStations.append(ps)
                }
                
            }
            catch {
                
            }
        }
        return petrolStations;
    }
}
