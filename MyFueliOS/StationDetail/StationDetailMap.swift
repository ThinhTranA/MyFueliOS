//
//  StationDetailMap.swift
//  MyFueliOS
//
//  Created by Hung Tran on 8/3/21.
//

import SwiftUI
import MapKit

struct StationDetailMap: UIViewRepresentable {
    @State var station: PetrolStation

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.mapType = MKMapType.standard
      
        if let coord2D = station.coordinate2D {
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coord2D, span: span)
            view.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coord2D

            annotation.title = station.address
            annotation.subtitle = station.description
            view.addAnnotation(annotation)
        }
    }
}

struct StationDetailMap_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailMap(station: PetrolStation.mockPetrolStations[1])
    }
}
