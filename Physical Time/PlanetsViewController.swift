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
    let oneEarthYear: Double = 5.0
    
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
    func animatePlanet(yearRatio: Double, radius: CGFloat, planet: UIImageView)
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
    
    
}
