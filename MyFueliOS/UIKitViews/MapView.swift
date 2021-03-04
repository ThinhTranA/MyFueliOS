//
//  MapView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 4/3/21.
//

import SwiftUI
import UIKit
import MapKit

class StationAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

struct MapView: UIViewRepresentable {
    
    @Binding var stations: [PetrolStation]

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
       
        let sts = stations.map { StationAnnotation(title: "\($0.title)", coordinate: CLLocationCoordinate2D(latitude: Double($0.latitude) ?? 0, longitude: Double($0.longitude) ?? 0))}

        uiView.annotations.forEach { uiView.removeAnnotation($0) }
        uiView.addAnnotations(sts)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        return MKMapView()
    }
}

