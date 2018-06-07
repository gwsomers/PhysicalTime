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
class PlanetsViewController: UIViewController
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
    
    // One revolution, in radians
    let revolutionInRadians: CGFloat = 2.0 * .pi
    // The "duration" of one earth year, where all other planets will use this value as a ratio for their
    // respective years
    var oneEarthYear: Double = 1.0
    // The intitial value of the stepper, to be used in `planetarySpeed()`
    var stepperVal: Double = 1.0
    
    /**
     On load, statically define the background and instantiate the Hero
     transition
     
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "planetsView"
        // Identifier for the WelcomeView, for the scope of this method
        let featureView: UIView! = FeatureViewController().view
        featureView.hero.id = "featureView"
        featureView.hero.modifiers = [.fade]
        
        // Setting the background programmatically
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "space.png")!)
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
        // Once again, re-animate the planets
        animateThePlanets()
    }
    
    /**
     Function instantiated when the Sun is tapped.
     */
    @objc private func sunTapped() -> Void
    {
        print("Sun works")
    }
    
    /**
     Function instantiated when Mercury is tapped.
     */
    @objc private func mercuryTapped() -> Void
    {
        print("Mercury works")
    }
    
    /**
     Function instantiated when Venus is tapped.
     */
    @objc private func venusTapped() -> Void
    {
        print("Venus works")
    }
    
    /**
     Function instantiated when the Earth is tapped.
     */
    @objc private func earthTapped() -> Void
    {
        print("Earth works")
    }
    
    /**
     Function instantiated when Mars is tapped.
     */
    @objc private func marsTapped() -> Void
    {
        print("Mars works")
    }
    
    /**
     Function instantiated when Jupiter is tapped.
     */
    @objc private func jupiterTapped() -> Void
    {
        print("Jupiter works")
    }
    
    /**
     Function instantiated when Saturn is tapped.
     */
    @objc private func saturnTapped() -> Void
    {
        print("Saturn works")
    }
    
    /**
     Function instantiated when Uranus is tapped.
     */
    @objc private func uranusTapped() -> Void
    {
        print("Uranus works")
    }
    
    /**
     Function instantiated when Neptune is tapped.
     */
    @objc private func neptuneTapped() -> Void
    {
        print("Mercury works")
    }
}
