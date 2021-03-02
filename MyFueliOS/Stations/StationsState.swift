//
//  StationsState.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 2/3/21.
//

import Foundation

class StationsState: ObservableObject {
    @Published var stations: [PetrolStation]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    func loadStations() {
        stations = PetrolStation.mockPetrolStations
    }
}
