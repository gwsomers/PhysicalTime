/**
 - Author:
 Xi Stephen Ouyang
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import CoreLocation

class WadokeiViewController: UIViewController {
    override func viewDidLoad() {
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "wadokeiView"
        // Identifier for the WelcomeView, for the scope of this method
        let featureView: UIView! = FeatureViewController().view
        featureView.hero.id = "featureView"
        featureView.hero.modifiers = [.fade]
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "shinji.jpg")!)
        super.viewDidLoad()
        let newView = WadokeiView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        newView.isOpaque = false
        view.addSubview(newView)
        let anglePosition = HandFormulas(hoursPerDay: 24, hourRevsPerDay: 1, minutesPerHour: 60, minuteRevsPerhour: 60,
                                            faceResetOffset: Float(Double.pi), timeResetOffset:0, mode:1)
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
    
    /**
     When the "Go" button is pressed, this function will instantiate the child view controller,
     `WadokeiInfoViewController`.
     
     - parameters:
     - sender: The event where the button is pressed
     
     - returns:
     Void
     */
    @IBAction func showPopup(_ sender: UIButton)
    {
        // Declare `popupViewController` to represent the `PlanetsPopUpViewController`
        let popupViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "wadokeiInfo")
            as! WadokeiInfoViewController
        // Declare `popupViewController` to be a child of this view controller
        self.addChildViewController(popupViewController)
        popupViewController.view.frame = self.view.frame
        self.view.addSubview(popupViewController.view)
        popupViewController.didMove(toParentViewController: self)
    }
}


