//
//  ViewController.swift
//  PhysicalTime
//
//  Created by Xi Stephen Ouyang on 3/5/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import UIKit

var clockSide: Int!
var totalHoursPerDay: Int!
var revolution: Int!
var clockHours: Int!
var modulus: Int!

class ViewController: UIViewController {
    
    let timer = Timer()
    var hoursPerDay: Int!
    var minutesPerHour: Int!
    var revolutionPerDay: Int!
    var minuteRevolutionPerHour: Int!
    var angleOffset: Float!
    var timeOffset: Int!
    var mode: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = View(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        newView.backgroundColor = UIColor.white
        view.addSubview(newView)

        let hourLayer = CAShapeLayer()
        hourLayer.frame = newView.frame
        let path = CGMutablePath()
        path.move(to: CGPoint(x: newView.frame.midX, y: newView.frame.midY))
        let anglePosition = Hand_Positioner(pPD: self.hoursPerDay, pRPD: self.revolutionPerDay, tPP: self.minutesPerHour, tRPP: self.minuteRevolutionPerHour, fRO: self.angleOffset, tRO: self.timeOffset, mode: self.mode)
        let hourAngle = anglePosition.partAngle(timeHour: getCurrentHour(), timeMin: getCurrentMinute(), timeSec: getCurrentSecond())
        let hourX = findxCoord(handLength: 70, angle:CGFloat(hourAngle))
        let hourY = findyCoord(handLength: 70, angle:CGFloat(hourAngle))
        path.addLine(to: CGPoint(x: newView.frame.midX + hourX, y: newView.frame.midY - hourY ))
        hourLayer.path = path
        hourLayer.lineWidth = 4.5
        hourLayer.lineCap = kCALineCapRound
        hourLayer.strokeColor = UIColor.red.cgColor
        self.view.layer.addSublayer(hourLayer)
        hourLayer.rasterizationScale = UIScreen.main.scale;
        hourLayer.shouldRasterize = true


        let minuteLayer = CAShapeLayer()
        minuteLayer.frame = newView.frame
        let mpath = CGMutablePath()
        mpath.move(to: CGPoint(x: newView.frame.midX, y: newView.frame.midY))
        let minuteAngle = anglePosition.tickAngle(timeHour: getCurrentHour(), timeMin: getCurrentMinute(), timeSec: getCurrentSecond())
        let MinX = findxCoord(handLength: 90, angle:CGFloat(minuteAngle))
        let MinY = findyCoord(handLength: 90, angle:CGFloat(minuteAngle))
        mpath.addLine(to: CGPoint(x: newView.frame.midX + MinX, y: newView.frame.midY - MinY ))
        minuteLayer.path = mpath
        minuteLayer.lineWidth = 3
        minuteLayer.lineCap = kCALineCapRound
        minuteLayer.strokeColor = UIColor.white.cgColor
        self.view.layer.addSublayer(minuteLayer)

        minuteLayer.rasterizationScale = UIScreen.main.scale;
        minuteLayer.shouldRasterize = true

        updateHand(currentLayer: hourLayer, duration: CFTimeInterval(anglePosition.partDuration()))
        updateHand(currentLayer: minuteLayer, duration: CFTimeInterval(anglePosition.tickDuration()))
        getCurrentTime()
        
        clockSide = self.minutesPerHour
        totalHoursPerDay = self.hoursPerDay
        revolution = self.revolutionPerDay
    }
    
    func findxCoord(handLength : CGFloat, angle: CGFloat)->CGFloat {
        return handLength * sin(angle)
    }
    
    func findyCoord(handLength : CGFloat, angle: CGFloat)->CGFloat {
        return handLength * cos(angle)
    }
    
    func getClockSide()-> Int {
        print("\(clockSide)")
        return clockSide
    }
    
    func getModulus()-> Int {
        clockHours = totalHoursPerDay / revolution
        //print("\(clockHours)")
        modulus = clockSide / clockHours
        return modulus
    }
    
    func updateHand(currentLayer: CALayer, duration: CFTimeInterval) {
        
        let angle = degree2radian(360)
        let animation = CABasicAnimation(keyPath:"transform.rotation.z")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = 0
        animation.repeatCount = Float.infinity
        animation.toValue = angle
        currentLayer.add(animation, forKey: "rotate")
        
    }
    
    func getCurrentTime() {
        
        let hour = getCurrentHour()
        let minutes = getCurrentMinute()
        let seconds = getCurrentSecond()
        print("time = \(hour):\(minutes):\(seconds)")
        
    }
    
    func getCurrentHour()-> Int {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    
    func getCurrentMinute()-> Int {
        let date = Date()
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        return minute
    }
    
    func getCurrentSecond()-> Int {
        let date = Date()
        let calendar = Calendar.current
        let second = calendar.component(.second, from: date)
        return second
    }

}






