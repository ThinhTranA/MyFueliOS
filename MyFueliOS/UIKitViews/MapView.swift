//
//  MapView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 4/3/21.
//

import SwiftUI
import UIKit
import MapKit


struct MapView: UIViewRepresentable {
    
    @Binding var stations: [PetrolStation]
    @Binding var selectedStation: PetrolStation?
    @Binding var shouldFocusUserLocation: Bool
    @State private var count = 0
    

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        
        //TODO: replace with user current gps location if available
        let coords = CLLocationCoordinate2D(latitude: -31.873768, longitude: 115.917665)
        // set span (radius of points)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: coords, span: span)

        // set the view
        mapView.setRegion(region, animated: true)
        
        mapView.isRotateEnabled = false
        //TODO: use something other than "phone" as id, though it is unique for that station :)

        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true

    /*    let places = stations.map { StationAnnotation(station: $0)}

        mapView.annotations.forEach { mapView.removeAnnotation($0) }
        mapView.addAnnotations(places)*/

        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
       // when focus button is tapped, unlikely that fuel type also changed. so, only re draw if necessary
        if(shouldFocusUserLocation){
            let locationManager = LocationManager.shared

              //Zoom to user location
              if let userLocation = locationManager.location?.coordinate {
                // set span (radius of points)
                let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                let region = MKCoordinateRegion(center: userLocation, span: span)

                // set the view
                mapView.setRegion(region, animated: true)
                shouldFocusUserLocation = true
              }
            return
        }

        //To avoid updating annotations of the same data on the map
        if mapView.annotations.count > 1 {
            if let currentFirstStationAnnotation = mapView.annotations[0] as? StationAnnotation {
                //TODO: cannot find self in scope crash trait here
                if(currentFirstStationAnnotation.fuelType == stations[0].fuelType && count == stations.count) {
                    return
                }
            }
        }
       
        count = stations.count
        let places = stations.map { StationAnnotation(station: $0)}

        mapView.annotations.forEach { mapView.removeAnnotation($0) }
        mapView.addAnnotations(places)

    }
    
    //= viewDidLoad in UIKit
    func makeCoordinator() -> MapCoordinator {
        .init(self)
    }
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView){
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            //make sure it is our petrol stations annotation and not anything else (eg: user's gps blue dot)
            guard let anno = annotation as?  StationAnnotation else { return nil }

            let stationAnnotationView = self.stationAnnotationView(in: mapView, for: annotation)
            stationAnnotationView.number = anno.price
            stationAnnotationView.logo = anno.logo
            return stationAnnotationView
        }
        
        private func stationAnnotationView(in mapView: MKMapView, for annotation: MKAnnotation) -> StationAnnotationView {
            let identifier = "CustomAnnotationViewID"

            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? StationAnnotationView {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let customAnnotationView = StationAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                customAnnotationView.canShowCallout = true
                return customAnnotationView
            }
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.shouldFocusUserLocation = false
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let anno = view.annotation as? StationAnnotation else {
                return
            }
            let identifer = anno.id
            print("phone selected: \(identifer)")
            if let selectedStation = parent.stations.first(where: {$0.phone == identifer}) {
                parent.selectedStation = selectedStation
            }
            
        }
        
    
    }
    
   
    
    
}

