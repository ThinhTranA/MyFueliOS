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
    let logo: String
    let fuelType: String
    
    init(station: PetrolStation) {
        self.id = station.phone
        self.title = station.tradingName
        self.price = station.price
        self.logo = station.logo
        self.fuelType = station.fuelType
        self.coordinate = CLLocationCoordinate2D(latitude: Double(station.latitude) ?? 0, longitude: Double(station.longitude) ?? 0)
    }
}

class StationAnnotationView: MKAnnotationView {
    private let frameWidth = 42
    private let frameHeight = 64
    private let logoWidth = 24
    private let logoHeight = 24
    private let annotationFrame: CGRect
    private let label: UILabel
    private let logoImg: UIImageView

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.annotationFrame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        self.label = UILabel(frame: annotationFrame.offsetBy(dx: 0, dy: -6))
        self.logoImg = UIImageView(frame:  CGRect(x: (frameWidth - logoWidth)/2, y: 0, width: logoWidth, height: logoHeight))
    
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        
        self.label.font = UIFont(name: "FjallaOne-Regular", size: 15)//    label.font = UIFont(name: "BabasNeue", size: 106)

        self.label.textColor = .black
        self.label.textAlignment = .center
        self.label.center.y = self.frame.height/2 - 20
        
        self.logoImg.center.y = self.frame.height/2
        self.logoImg.center.x = self.frame.width/2 - 1
        
        self.backgroundColor = .clear
        self.addSubview(label)
        self.addSubview(logoImg)
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
    
    public var logo: String = "" {
        didSet {
            let image = UIImage(imageLiteralResourceName: logo)
            self.logoImg.image =  image
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
