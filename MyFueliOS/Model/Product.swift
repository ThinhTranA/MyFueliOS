//
// Created by Thinh Tran on 29/3/21.
//

import Foundation

enum Product: Int, CaseIterable {
    case UnleadedPetrol = 1
    case PremiumUnleaded = 2
    case Diesel = 4
    case LPG = 5
    case Ron98 = 6
    case E85 = 10
    case BrandDiesel = 11

    var description : String {
        switch self {
        case .UnleadedPetrol: return "Unleaded Petrol"
        case .PremiumUnleaded: return "Premium Unleaded"
        case .Diesel: return "Diesel"
        case .LPG : return "LPG"
        case .Ron98 : return "Ron 98"
        case .E85 : return "E85"
        case .BrandDiesel : return "Brand Diesel"
        }
    }

    var shortDescription: String {
        switch self {
        case .UnleadedPetrol: return "ULP"
        case .PremiumUnleaded: return "PULP"
        case .Diesel: return "Diesel"
        case .LPG : return "LPG"
        case .Ron98 : return "98RON"
        case .E85 : return "E85"
        case .BrandDiesel : return "BDiesel"
        }
    }
}
