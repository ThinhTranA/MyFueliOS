//
//  PetrolStation.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 2/3/21.
//

import Foundation
import MapKit
import CoreLocation

struct PetrolStation: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let brand: String
    let date: String
    let price: String
    let tradingName: String
    let location: String
    let address: String
    let phone: String
    let latitude: String
    let longitude: String
    let siteFeatures: String
    var name: String{
        return String(title.dropFirst(7))
    }

    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
    }

    var logo : String {
        return makeLogo()
    }
    var distance: String {
        //TODO: calculate from user GPS location
        let distance = calDistance()
        return distance > 1000 ? String(format: "%.2f km", distance/1000) : String(format: "%.0f m", distance)
    }
    
    func calDistance() -> Double {
//        <latitude>-31.925213</latitude>
//        <longitude>115.951987</longitude>
        //TODO: User GPS not granted??? , also replace with user coordinate
        let userCoordinate = CLLocation(latitude: -31.925213, longitude: 115.951987)
        let stationCoordinate = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)

        let distanceInMeters = userCoordinate.distance(from: stationCoordinate)
        return distanceInMeters
    }


    func makeLogo() -> String{
        var logo : String
        //condition to load correct logo
        switch brand {
            case "7-Eleven":
                logo = "7-Eleven"
            case "BP":
                logo = "BP"
            case "Caltex":
                logo = "Caltex"
            case "Coles Express":
                logo = "Coles"
            case "Puma":
                logo = "Puma"
            case "Shell":
                logo = "Shell"
            default:
                logo = "Fuel"
        }
        return logo

    }






}


