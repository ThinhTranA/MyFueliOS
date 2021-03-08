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
                
            }
            catch {
                
            }
        }
        return petrolStations;
    }

    



}


