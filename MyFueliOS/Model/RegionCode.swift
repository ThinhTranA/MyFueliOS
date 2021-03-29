//
// Created by Thinh Tran on 29/3/21.
//

import Foundation

enum RegionCode: Int, CaseIterable {
    case Perth = 0
    case Albany = 15
    case AugustaMargaretRiver = 28
    case BridgetownGreenbushes = 30
    case Boulder = 1
    case Broome = 2
    case Bunbury = 16
    case BusseltonTownsite = 3
    case BusseltonShire = 29
    case Capel = 19
    case Carnarvon = 4
    case Cataby = 33
    case Collie = 5
    case Coolgardie = 34
    case Cunderdin = 35
    case DonnybrookBalingup = 31
    case Dalwallinu = 36
    case Dampier = 6
    case Dardanup = 20
    case Denmark = 37
    case Derby = 38
    case Dongara = 39
    case Esperance = 7
    case Exmouth = 40
    case FitzroyCrossing = 41
    case Geraldton = 17
    case Greenough = 21
    case Harvey = 22
    case Jurien = 42
    case Kalgoorlie = 8
    case Kambalda = 43
    case Karratha = 9
    case Kellerberrin = 44
    case Kojonup = 45
    case Kununurra = 10
    case Mandurah = 18
    case Manjimup = 32
    case Meckering = 58
    case Meekatharra = 46
    case Moora = 47
    case MtBarker = 48
    case Munglinup = 61
    case Murray = 23
    case Narrogin = 11
    case Newman = 49
    case Norseman = 50
    case NorthBannister = 60
    case Northam = 12
    case NorthamShire = 62
    case PortHedland = 13
    case Ravensthorpe = 51
    case RegansFord = 57
    case SouthHedland = 14
    case Tammin = 53
    case Waroona = 24
    case Williams = 54
    case Wubin = 55
    case Wundowie = 59
    case York = 56

    var text : String {
        switch self {
        case.Perth : return "Perth"
        case.Albany: return "Albany"
        case.AugustaMargaretRiver: return "August / Margaret River"
        case.BridgetownGreenbushes: return "Bridgetown / Greenbushes"
        case.Boulder: return "Boulder"
        case.Broome: return "Broome"
        case.Bunbury: return "Bunbury"
        case.BusseltonTownsite: return "Busselton (Townsite)"
        case.BusseltonShire: return "Busselton (Shire)"
        case.Capel: return "Capel"
        case.Carnarvon: return "Carnarvon"
        case.Cataby: return "Cataby"
        case.Collie: return "Collie"
        case.Coolgardie: return "Coolgardie"
        case.Cunderdin: return "Cunderdin"
        case.DonnybrookBalingup: return "Donnybrook / Balingup"
        case.Dalwallinu: return "Dalwallinu"
        case.Dampier: return "Dampier"
        case.Dardanup: return "Dardanup"
        case.Denmark: return "Denmark"
        case.Derby: return "Derby"
        case.Dongara: return "Dongara"
        case.Esperance: return "Esperance"
        case.Exmouth: return "Exmouth"
        case.FitzroyCrossing: return "Fitzroy Crossing"
        case.Geraldton: return "Geraldton"
        case.Greenough: return "Greenough"
        case.Harvey: return "Harvey"
        case.Jurien: return "Jurien"
        case.Kalgoorlie: return "Kalgoorlie"
        case.Kambalda: return "Kambalda"
        case.Karratha: return  "Karratha"
        case.Kellerberrin: return "Kellerberrin"
        case.Kojonup: return "Kojonup"
        case.Kununurra: return "Kununurra"
        case.Mandurah: return "Mandurah"
        case.Manjimup: return "Manjimup"
        case.Meckering: return "Meckering"
        case.Meekatharra: return "Meekatharra"
        case.Moora: return "Moora"
        case.MtBarker: return "Mt Barker"
        case.Munglinup: return "Munglinup"
        case.Murray: return "Murray"
        case.Narrogin: return "Narrogin"
        case.Newman: return "Newman"
        case.Norseman: return "Norseman"
        case.NorthBannister: return "North Bannister"
        case.Northam: return "Northam"
        case.NorthamShire: return "Northam (Shire)"
        case.PortHedland: return "PortHedland"
        case.Ravensthorpe: return "Ravensthorpe"
        case.RegansFord: return "RegansFord"
        case.SouthHedland: return "SouthHedland"
        case.Tammin: return "Tammin"
        case.Waroona: return "Waroona"
        case.Williams: return "Williams"
        case.Wubin: return "Wubin"
        case.Wundowie: return "Wundowie"
        case.York: return "York"
        }
    }
}
