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
    let id: String
    let price: String
    let brand: String
    
    init(station: PetrolStation) {
        self.id = station.phone
        self.title = station.title
        self.price = station.price
        self.brand = station.brand
        self.coordinate = CLLocationCoordinate2D(latitude: Double(station.latitude) ?? 0, longitude: Double(station.longitude) ?? 0)
    }
}

class CustomAnnotationView: MKAnnotationView {
    private let annotationFrame = CGRect(x: 0, y: 0, width: 40, height: 50)
    private let label: UILabel

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.label = UILabel(frame: annotationFrame.offsetBy(dx: 0, dy: -6))
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        self.label.font = UIFont.systemFont(ofSize: 16)
        self.label.textColor = .black
        self.label.textAlignment = .center
        self.backgroundColor = .clear
        self.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }

    public var number: String = "0"
    
    {
        didSet {
            self.label.text = String(number)
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //// Resize to Target Frame
        context.saveGState()

        context.translateBy(x: rect.minX, y: rect.minY)
        context.scaleBy(x: rect.width / 40, y: rect.height / 49)

        //// Group
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40))
        UIColor.white.setFill()
        ovalPath.fill()

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 6, y: 34))
        bezierPath.addLine(to: CGPoint(x: 20, y: 49))
        bezierPath.addLine(to: CGPoint(x: 34, y: 34))
        UIColor.white.setFill()
        bezierPath.fill()
        
        context.restoreGState()
    }

}

struct MapView: UIViewRepresentable {
    
    @Binding var stations: [PetrolStation]
    @Binding var selectedStation: PetrolStation?
    

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
        let places = stations.map { StationAnnotation(station: $0)}

        mapView.annotations.forEach { mapView.removeAnnotation($0) }
        mapView.addAnnotations(places)
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {

        
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

            let customAnnotationView = self.customAnnotationView(in: mapView, for: annotation)
            customAnnotationView.number = anno.price
            return customAnnotationView
        }
        
        private func customAnnotationView(in mapView: MKMapView, for annotation: MKAnnotation) -> CustomAnnotationView {
            let identifier = "CustomAnnotationViewID"

            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let customAnnotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                customAnnotationView.canShowCallout = true
                return customAnnotationView
            }
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

