/**
 - Author:
 Xi Stephen Ouyang
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import CoreLocation
/**
 Class that extends the UIViewController to draws the wadokei clock
 */
class WadokeiViewController: UIViewController {
    override func viewDidLoad() {
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "wadokeiView"
        // Identifier for the WelcomeView, for the scope of this method
        let featureView: UIView! = FeatureViewController().view
        featureView.hero.id = "featureView"
        featureView.hero.modifiers = [.fade]
        
        //set background of view to shinji
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "shinji.jpg")!)
        super.viewDidLoad()
        // initializes as a new subview using WadokeiFace.swift to draw the clock face
        let newView = WadokeiView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        // makes newView background transparent to show the background in the main view
        newView.isOpaque = false
        // adds the subview to the current view
        view.addSubview(newView)
        
        //initializes anglePosition to call Handformulas
        let anglePosition = HandFormulas(hoursPerDay: 24, hourRevsPerDay: 1, minutesPerHour: 60, minuteRevsPerhour: 60,
                                            faceResetOffset: Float(Double.pi), timeResetOffset:0, mode:1)
        //initiates an hour layer to draw the hour hand on
        let hourLayer = CAShapeLayer()
        hourLayer.frame = newView.frame
        //starts the draw point in the middle of the clock
        let path = CGMutablePath()
        path.move(to: CGPoint(x: newView.frame.midX, y: newView.frame.midY))
        // Grab the angle positioning for an hour hand on a 24 hour clock
        let hourAngle = anglePosition.hourAngle(timeHour: getCurrentHour(), timeMin: getCurrentMinute(), timeSec: getCurrentSecond())
        // finds the x and y coordinate from midpoint with 100 length using helper function findxCoord and findyCoord
        let hourX = findxCoord(handLength: 100, angle:CGFloat(hourAngle))
        let hourY = findyCoord(handLength: 100, angle:CGFloat(hourAngle))
        
        //draws the path to x and y coordinate
        path.addLine(to: CGPoint(x: newView.frame.midX + hourX, y: newView.frame.midY - hourY ))
        hourLayer.path = path
        hourLayer.lineWidth = 4.5
        hourLayer.lineCap = kCALineCapRound
        hourLayer.strokeColor = UIColor.white.cgColor
        self.view.layer.addSublayer(hourLayer)
        hourLayer.rasterizationScale = UIScreen.main.scale;
        hourLayer.shouldRasterize = true
        
        //animates the hour hand (rotate it a full revolution in 24 hours) using helper function updateHand
        updateHand(currentLayer: hourLayer, duration: CFTimeInterval(anglePosition.hourDuration()))
        
    }
    /**
     helper function that gets the x coordinate given the angle and length of a line
     - parameters:
     handLength:length of hand line
     angle: angle to find x coordinate
     -returns :CGFloat
     */
    func findxCoord(handLength : CGFloat, angle: CGFloat)->CGFloat {
        return handLength * sin(angle)
    }
    /**
     helper function that gets the y coordinate given the angle and length of a line
     - parameters:
     handLength:length of hand line
     angle: angle to find y coordinate

     -returns :CGFloat
     */
    func findyCoord(handLength : CGFloat, angle: CGFloat)->CGFloat {
        return handLength * cos(angle)
    }
    /**
     helper function that rotates a layer given revolutions per timeinterval
     - parameters:
     currentLayer: layer to rotate
     duration: amount of time it takes to revolve one revolution
     -returns nil
     */
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
    /**
     helper function that gets the current hour
     
     -returns :Int
     */
    func getCurrentHour()-> Int
    {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    /**
     helper function that gets the current minute
     
     -returns :Int
     */
    func getCurrentMinute()-> Int
    {
        let date = Date()
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        return minute
    }
    /**
     helper function that gets the current second
     
     -returns :Int
     */
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


