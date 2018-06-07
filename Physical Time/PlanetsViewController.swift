/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import Hero

/**
 In this class, we will animate the PlanetsViewController using vanilla
 UIKit to simulate the moving of the planets.
 */
class PlanetsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    // All the planets in our view (in order)
    @IBOutlet weak var mercury: UIImageView!
    @IBOutlet weak var venus: UIImageView!
    @IBOutlet weak var earth: UIImageView!
    @IBOutlet weak var mars: UIImageView!
    @IBOutlet weak var jupiter: UIImageView!
    @IBOutlet weak var saturn: UIImageView!
    @IBOutlet weak var uranus: UIImageView!
    @IBOutlet weak var neptune: UIImageView!
    // The picker view for our controller
    @IBOutlet weak var pickerView: UIPickerView!
    // Label for the current orbit speed
    @IBOutlet weak var speedLabel: UILabel!
    
    
    // Selection of values to pick from for the pickerView
    let planets: [String] = [
        "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"
    ]
    // One revolution, in radians
    let revolutionInRadians: CGFloat = 2.0 * .pi
    // The "duration" of one earth year, where all other planets will use this value as a ratio for their
    // respective years
    var oneEarthYear: Double = 8.0
    // The intitial value of the stepper, to be used in `planetarySpeed()`
    var stepperVal: Double = 1.0
    // The current planet value (Mercury is the default)
    var pickerSelection: String = "Mercury"
    
    /**
     On load, statically define the background and instantiate the Hero
     transition
     
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Picker view set up
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "planetsView"
        // Identifier for the WelcomeView, for the scope of this method
        let featureView: UIView! = FeatureViewController().view
        featureView.hero.id = "featureView"
        featureView.hero.modifiers = [.fade]
        
        // Setting the background programmatically
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "space.png")!)
        
        // Set the text of our speed label accordingly
        speedLabel.text = "Current Speed: 1.0x"
    }
    
    /**
     Here, we will be rotating our planets accordingly.
     See https://youtu.be/4SLJjuu3Jss
     
     - returns:
     nil
     */
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        // Animating the planets for the first time
        animateThePlanets()
    }
    
    /**
     Helper function used by `UIPickerView` to return the number of components
     
     - returns:
     A static integer, 1
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    /**
     Helper function used by `UIPickerView` to return the number of planets in our
     picker view (in our case, 8)
     
     - returns:
     Total number of planets as an int
     */
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int
    {
        return planets.count
    }
    
    /**
     Helper function used by `UIPickerView` to dynamically style the picker view element.
     
     - returns:
     A `UIView` object representing a single item in the picker view
     */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView
    {
        // Instantiate a new UILabel
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil
        {
            pickerLabel = UILabel()
            // Set font, size, and color accordingly
            pickerLabel?.font = UIFont(name: "Arvo", size: 15)
            pickerLabel?.textColor = UIColor.white
            pickerLabel?.textAlignment = .center
        }
        // Create the name for the label, and a border as well
        pickerLabel?.text = planets[row]
        pickerLabel?.layer.borderColor = UIColor.white.cgColor
        pickerLabel?.layer.borderWidth = 3.0
        
        return pickerLabel!
    }
    
    /**
     Helper function used by `UIPickerView` to instantiate an action based on the selection
     of the user
     
     - returns:
     Void
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        pickerSelection = planets[row]
        print(pickerSelection)
    }
    
    /**
     This function will instantiate the animating of all planets. It is
     modularized in such a fashion that it may be called when the class
     variable, `oneEarthYear`, is increased or decreased by the stepper
     in the app.
     
     - returns:
     nil
     */
    func animateThePlanets() -> Void
    {
        // Animating all the planets (see docstrings for details)
        animatePlanet(yearRatio: 0.2410136986, radius: distanceFromSun(planet: mercury),
                      planet: mercury)
        
        animatePlanet(yearRatio: 0.6156164384, radius: distanceFromSun(planet: venus),
                      planet: venus)
        animatePlanet(yearRatio: 1.0, radius: distanceFromSun(planet: earth),
                      planet: earth)
        animatePlanet(yearRatio: 1.88, radius: distanceFromSun(planet: mars),
                      planet: mars)
        animatePlanet(yearRatio: 11.86, radius: distanceFromSun(planet: jupiter),
                      planet: jupiter)
        animatePlanet(yearRatio: 29.46, radius: distanceFromSun(planet: saturn),
                      planet: saturn)
        animatePlanet(yearRatio: 84.01, radius: distanceFromSun(planet: uranus),
                      planet: uranus)
        animatePlanet(yearRatio: 164.79, radius: distanceFromSun(planet: neptune),
                      planet: neptune)
    }
    
    /**
     This calculates the difference between the x-coordinate of the middle of the frame, or the "Sun",
     and the statically defined x-coordinate of a "planet", or given `UIImageView`.
     
     - parameters:
     - planet: The planet, or the `UIImageView` specified by the caller
     
     - returns:
     A CGFloat value indicating the aforementioned difference between the two.
     */
    func distanceFromSun(planet: UIImageView) -> CGFloat
    {
        return view.frame.midX - planet.frame.origin.x
    }
    
    /**
     Helper function to animate a given "planet", or `UIImageView` object.
     
     - parameters:
     - yearRatio: The ratio of the year of the specified planet, relative to Earth
     - radius: The position of the "planet" relative to the center of the screen, or the "Sun"
     - planet: The `UIImageView` for the given planet
     
     - returns:
     nil
     */
    func animatePlanet(yearRatio: Double, radius: CGFloat, planet: UIImageView) -> Void
    {
        // Specified path for the respective planet
        let path: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY),
                                                   radius: radius, startAngle: 0,
                                                   endAngle: revolutionInRadians, clockwise: true)
        // The line of the path, define the path, and set the colors accordingly
        let pathLine = CAShapeLayer()
        // Set this line to a lower priority than the planet (the default priority is 0, so we don't
        // declare it in this case for the planet)
        pathLine.zPosition = -1
        pathLine.path = path.cgPath
        pathLine.strokeColor = UIColor.white.cgColor
        pathLine.fillColor = UIColor.clear.cgColor
        pathLine.lineWidth = 0.2
        view.layer.addSublayer(pathLine)
        // The animation of the planet
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = oneEarthYear * yearRatio
        animation.repeatCount = MAXFLOAT
        animation.path = path.cgPath
        // Add the respective layer for the specified planet
        planet.layer.add(animation, forKey: nil)
    }
    
    /**
     This is the case where the user chooses to speed up or speed down the planetary
     speed via the stepper, and thus we must accelerate the value of 
     
     - returns:
     nil
     */
    @IBAction func planetarySpeed(_ sender: UIStepper)
    {
        // If the sender's value is greater than the initial
        // value recorded in the class variable, then make
        // the value of one Earth year greater. If not, then
        // make it less, or "faster"
        if sender.value < stepperVal
        {
            oneEarthYear = oneEarthYear * 2.0
        }
        else
        {
            oneEarthYear = oneEarthYear / 2.0
        }
        // Initialize stepperVal to be the new value of the new
        // value set by the stepper
        stepperVal = sender.value
        // Switch statement to see what the value of `stepperVal` is, to update
        // our `speedLabel` accordingly
        updateSpeedLabel(stepperVal: stepperVal)
        // Once again, re-animate the planets
        animateThePlanets()
    }
    
    /**
     Simple helper function that instantiates a switch statement, and will determine
     what the updated value of the `speedLabel` should be. For example, if the value of
     the stepper is at 5, then we are at a current speed of 1x. If we are at 6, we have
     applied a 2x multiplier, at 7 a 4x multiplier, and so forth.
     
     - parameters:
     - stepperVal: The value of the current stepper, which will determine the multiplier
                    we update our label by
     
     - returns:
     Void
     */
    func updateSpeedLabel(stepperVal: Double) -> Void
    {
        // The prefix, or beginning, of every string
        let prefix: String = "Current Speed: "
        switch(stepperVal)
        {
            case 1.0:
                speedLabel.text = prefix + "0.0625x"
            case 2.0:
                speedLabel.text = prefix + "0.125x"
            case 3.0:
                speedLabel.text = prefix + "0.25x"
            case 4.0:
                speedLabel.text = prefix + "0.5x"
            case 5.0:
                speedLabel.text = prefix + "1.0x"
            case 6.0:
                speedLabel.text = prefix + "2.0x"
            case 7.0:
                speedLabel.text = prefix + "4.0x"
            case 8.0:
                speedLabel.text = prefix + "8.0x"
            case 9.0:
                speedLabel.text = prefix + "16.0x"
            default:
                speedLabel.text = prefix + "32.0x"
        }
    }
}
