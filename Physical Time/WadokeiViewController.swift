//
//  WadokeiViewController.swift
//  Physical_Time_Analog_Clock
//
//  Created by Xi Stephen Ouyang on 5/23/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class WadokeiViewController: UIViewController {
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "wadokeiView"
        // Identifier for the WelcomeView, for the scope of this method
        let featureView: UIView! = FeatureViewController().view
        featureView.hero.id = "featureView"
        featureView.hero.modifiers = [.fade]
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "tatami.jpg")!)
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        super.viewDidLoad()
        let newView = WadokeiView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        newView.isOpaque = false
        view.addSubview(newView)
        let anglePosition = HandFormulas(pPD: 24, pRPD: 1, tPP: 60, tRPP: 60,
                                            fRO: Float(Double.pi), tRO:0, mode:1, locMan: locationManager)
        let hourLayer = CAShapeLayer()
        hourLayer.frame = newView.frame
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: newView.frame.midX, y: newView.frame.midY))
        let hourAngle = anglePosition.hourAngle(timeHour: getCurrentHour(), timeMin: getCurrentMinute(), timeSec: getCurrentSecond())
        let hourX = findxCoord(handLength: 100, angle:CGFloat(hourAngle))
        let hourY = findyCoord(handLength: 100, angle:CGFloat(hourAngle))
        path.addLine(to: CGPoint(x: newView.frame.midX + hourX, y: newView.frame.midY - hourY ))
        hourLayer.path = path
        hourLayer.lineWidth = 4.5
        hourLayer.lineCap = kCALineCapRound
        hourLayer.strokeColor = UIColor.white.cgColor
        self.view.layer.addSublayer(hourLayer)
        hourLayer.rasterizationScale = UIScreen.main.scale;
        hourLayer.shouldRasterize = true
        
        updateHand(currentLayer: hourLayer, duration: CFTimeInterval(anglePosition.hourDuration()))
        
    }
    
    func findxCoord(handLength : CGFloat, angle: CGFloat)->CGFloat {
        return handLength * sin(angle)
    }
    
    func findyCoord(handLength : CGFloat, angle: CGFloat)->CGFloat {
        return handLength * cos(angle)
    }
    func updateHand(currentLayer: CALayer, duration: CFTimeInterval)
    {
        let angle = degree2radian(360)
        let animation = CABasicAnimation(keyPath:"transform.rotation.z")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = 0
        animation.repeatCount = Float.infinity
        animation.toValue = angle
        currentLayer.add(animation, forKey: "rotate")
    }
    func getCurrentHour()-> Int
    {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    
    func getCurrentMinute()-> Int
    {
        let date = Date()
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        return minute
    }
    
    func getCurrentSecond()-> Int
    {
        let date = Date()
        let calendar = Calendar.current
        let second = calendar.component(.second, from: date)
        return second
    }
    
}

extension WadokeiViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("succeeded in getting locations")
    }
}


