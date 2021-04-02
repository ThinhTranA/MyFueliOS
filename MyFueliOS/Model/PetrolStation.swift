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
    let fuelType: String
    let fuelTypeDescription: String

    var product: Product {
        return Product.UnleadedPetrol
    }

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let theDate = dateFormatter.date(from: date)

        if let theDate = theDate {
            if(Calendar.current.isDateInToday(theDate)){
                return "Today"
            }
            else if ( Calendar.current.isDateInTomorrow(theDate)){
                return "Tomorrow"
            }
        }

        return "InvalidDate"
    }

    var dateFormattedText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let theDate = dateFormatter.date(from: date)

        if let theDate = theDate {
            if(Calendar.current.isDateInToday(theDate)){
                return "Today"
            }
            else if ( Calendar.current.isDateInTomorrow(theDate)){
                return "Tomorrow"
            }
        }

        return "InvalidDate"
    }
  
    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
    }

    var logo : String {
        return makeLogo()
    }
    var distance: Double?{
       return calDistance()
    }
    var distanceString: String {
        let distance = calDistance()
        if let distance = distance {
            return distance > 1000 ? String(format: "%.2f km", distance/1000) : String(format: "%.0f m", distance)
        }
        return "Unknown"
    }
    
    func calDistance() -> Double? {
        if let userLocation = LocationManager.shared.location?.coordinate {
            let userCoordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let stationCoordinate = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)

            let distanceInMeters = userCoordinate.distance(from: stationCoordinate)
            return distanceInMeters
        }
        
        return nil
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

    func GetProductType() -> Product {
        switch fuelType {
        case Product.UnleadedPetrol.shortDescription:
            return Product.UnleadedPetrol
        case Product.PremiumUnleaded.shortDescription:
            return Product.PremiumUnleaded
        case Product.Diesel.shortDescription:
            return Product.Diesel
        case Product.LPG.shortDescription:
            return Product.LPG
        case Product.Ron98.shortDescription:
            return Product.Ron98
        case Product.E85.shortDescription:
            return Product.E85
        case Product.BrandDiesel.shortDescription:
            return Product.BrandDiesel
        default:
            return Product.UnleadedPetrol
        }
    }

}


