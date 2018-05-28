/**
 - Author:
 Xi Stephen Ouyang
 Created for Physical Time, 2018
 */

import UIKit
import CoreLocation

var clockSide: Int!
var totalHoursPerDay: Int!
var revolution: Int!
var clockHours: Int!
var modulus: Int!
let defaults = UserDefaults.standard

class ViewController: UIViewController {
    
    let timer = Timer()
    let locationManager = CLLocationManager()
    var hoursPerDay: Int! = defaults.integer(forKey: defaultHandValues.hoursPerDay)
    var minutesPerHour: Int! = defaults.integer(forKey: defaultHandValues.minsPerHour)
    var revolutionPerDay: Int! = defaults.integer(forKey: defaultHandValues.hourRevsPerDay)
    var minuteRevolutionPerHour: Int! = defaults.integer(forKey: defaultHandValues.minRevsPerHour)
    var angleOffset: Float! = defaults.float(forKey: defaultHandValues.FaceOffset)
    var timeOffset: Int! = defaults.integer(forKey: defaultHandValues.TimeOffset)
    var mode: Int! = defaults.integer(forKey: defaultHandValues.mode)
  
 override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeDefaultsIfNeeded()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        let background = ChangeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
        let newView = View(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        newView.isOpaque = false
        view.addSubview(newView)

        let hourLayer = CAShapeLayer()
        hourLayer.frame = newView.frame
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: newView.frame.midX, y: newView.frame.midY))
        let anglePosition = HandFormulas(pPD: self.hoursPerDay, pRPD: self.revolutionPerDay, tPP: self.minutesPerHour, tRPP: self.minuteRevolutionPerHour,
                                            fRO: self.angleOffset, tRO: self.timeOffset, mode: self.mode, locMan: locationManager)
        let hourAngle = anglePosition.hourAngle(timeHour: getCurrentHour(), timeMin: getCurrentMinute(), timeSec: getCurrentSecond())
        let hourX = findxCoord(handLength: 100, angle:CGFloat(hourAngle))
        let hourY = findyCoord(handLength: 100, angle:CGFloat(hourAngle))
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
        let minuteAngle = anglePosition.minuteAngle(timeHour: getCurrentHour(), timeMin: getCurrentMinute(), timeSec: getCurrentSecond())
        let MinX = findxCoord(handLength: 120, angle:CGFloat(minuteAngle))
        let MinY = findyCoord(handLength: 120, angle:CGFloat(minuteAngle))
        mpath.addLine(to: CGPoint(x: newView.frame.midX + MinX, y: newView.frame.midY - MinY ))
        minuteLayer.path = mpath
        minuteLayer.lineWidth = 3
        minuteLayer.lineCap = kCALineCapRound
        minuteLayer.strokeColor = UIColor.white.cgColor
        self.view.layer.addSublayer(minuteLayer)

        minuteLayer.rasterizationScale = UIScreen.main.scale;
        minuteLayer.shouldRasterize = true

        updateHand(currentLayer: hourLayer, duration: CFTimeInterval(anglePosition.hourDuration()))
        updateHand(currentLayer: minuteLayer, duration: CFTimeInterval(anglePosition.minuteDuration()))
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
    
    func getModulus()-> Int
    {
        clockHours = totalHoursPerDay / revolution
        //print("\(clockHours)")
        modulus = clockSide / clockHours
        return modulus
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
    
    func getCurrentTime()
    {
        let hour = getCurrentHour()
        let minutes = getCurrentMinute()
        let seconds = getCurrentSecond()
        print("time = \(hour):\(minutes):\(seconds)")
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
    func initializeDefaultsIfNeeded(){
        if (hoursPerDay == 0)
        {
            hoursPerDay = 24
        }
        if (minutesPerHour == 0)
        {
            minutesPerHour = 60
        }
        if (revolutionPerDay == 0)
        {
            revolutionPerDay = 2
        }
        if (minuteRevolutionPerHour == 0)
        {
            minuteRevolutionPerHour = 1
        }
        if (mode == 0)
        {
            mode = NOON_MODE
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("succeeded in getting locations")
    }
}





