//
//  StationAnnotation.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 7/3/21.
//

import Foundation
import MapKit
import UIKit

class StationAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let id: String
    let price: String
    let brand: String
    
    init(station: PetrolStation) {
        self.id = station.phone
        self.title = station.tradingName
        self.price = station.price
        self.brand = station.brand
        self.coordinate = CLLocationCoordinate2D(latitude: Double(station.latitude) ?? 0, longitude: Double(station.longitude) ?? 0)
    }
}

class StationAnnotationView: MKAnnotationView {
    private let frameWidth = 42
    private let frameHeight = 64
    private let logoWidth = 28
    private let logoHeight = 28
    private let annotationFrame: CGRect
    private let label: UILabel
    private let logo: UIImageView

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.annotationFrame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        self.label = UILabel(frame: annotationFrame.offsetBy(dx: 0, dy: -6))
        self.logo = UIImageView(frame:  CGRect(x: (frameWidth - logoWidth)/2, y: 0, width: logoWidth, height: logoHeight))
    
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        
        self.label.font = UIFont.systemFont(ofSize: 15)
        self.label.textColor = .black
        self.label.textAlignment = .center
        self.label.center.y = self.frame.height/2 - 20
        
        self.logo.center.y = self.frame.height/2
        self.logo.center.x = self.frame.width/2 - 1
        
        self.backgroundColor = .clear
        self.addSubview(label)
        self.addSubview(logo)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }

    public var number: String = "???"
    {
        didSet {
            self.label.text = String(number)
        }
    }
    
    public var brand: String = "" {
        didSet {
//            //TODO: update to use brand logo
//            switch brand {
//            case "Caltex":
//                UIImage("Caltex")
//            default:
//                UIImage(systemName: "pencil.circle.fill")
//            }
            let image = UIImage(systemName: "pencil.circle.fill")
            self.logo.image =  image
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
   
        context.saveGState()
        let ovalPath = UIBezierPath()
        ovalPath.move(to: CGPoint(x: 13.41, y: 46.06))
        ovalPath.addCurve(to: CGPoint(x: 0.17, y: 22.24), controlPoint1: CGPoint(x: 8.33, y: 40.17), controlPoint2: CGPoint(x: 0.17, y: 32.49))
        ovalPath.addCurve(to: CGPoint(x: 2.82, y: 4.76), controlPoint1: CGPoint(x: 0.17, y: 15.42), controlPoint2: CGPoint(x: -1.01, y: 9.11))
        ovalPath.addCurve(to: CGPoint(x: 20.03, y: 0), controlPoint1: CGPoint(x: 6.38, y: 0.73), controlPoint2: CGPoint(x: 14.75, y: 0))
        ovalPath.addCurve(to: CGPoint(x: 37.24, y: 4.76), controlPoint1: CGPoint(x: 25.5, y: 0), controlPoint2: CGPoint(x: 33.65, y: 0.47))
        ovalPath.addCurve(to: CGPoint(x: 39.88, y: 22.24), controlPoint1: CGPoint(x: 40.84, y: 9.08), controlPoint2: CGPoint(x: 39.88, y: 15.65))
        ovalPath.addCurve(to: CGPoint(x: 20.03, y: 54), controlPoint1: CGPoint(x: 39.88, y: 32.62), controlPoint2: CGPoint(x: 34.25, y: 36.38))
        UIColor.white.setFill()
        ovalPath.fill()
        context.restoreGState()
    }

}
