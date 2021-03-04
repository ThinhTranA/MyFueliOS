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
    
    init(title: String?, lat: String, long: String) {
        self.title = title
        self.coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0, longitude: Double(long) ?? 0)
    }
}

struct MapView: UIViewRepresentable {
    
    @Binding var stations: [PetrolStation]
    

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        //TODO: mapView.setRegion(location.gps, animated: false)
        mapView.isRotateEnabled = false
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {

        let places = stations.map { StationAnnotation(title: "\($0.title)", lat: $0.latitude, long: $0.longitude)}

        uiView.annotations.forEach { uiView.removeAnnotation($0) }
        uiView.addAnnotations(places)
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> MapCoordinator {
        .init()
    }
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            guard let placeAnnotation = annotation as? PetrolStation else {
//                return nil
//            }
//
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "petrolstation") as? MKMarkerAnnotationView
//                ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Petrol Station")
//            annotationView.canShowCallout = true
//            annotationView.glyphText = "eaa"
//            annotationView.markerTintColor = UIColor(displayP3Red: 0.082, green: 0.518, blue: 0.263, alpha: 1.0)
//            annotationView.titleVisibility = .visible
//            annotationView.detailCalloutAccessoryView = UIImage(named: placeAnnotation.tradingName).map(UIImageView.init)
//
//            return annotationView
//            
//        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("station selected")
        }
    }
    
   
    
    
}

