//
//  PetrolStation.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 2/3/21.
//

import Foundation

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
}

