/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit

/**
 This is the class that represents the pop-up for a given planet that is clicked
 on in the `PlanetsViewController`. It will display information depending on the
 planet chosen. See https://youtu.be/FgCIRMz_3dE
 */
class PlanetsPopUpViewController: UIViewController
{
    // Text view for our planets description
    @IBOutlet weak var planetsTextView: UITextView!
    // Predefined dictionary of values to make calculations for the speeds of all planets
    // at a 1x multiple
    let planetValues: [String: Double] = [
        "mercuryRotation": 58.6,
        "mercuryRevolution": 87.97,
        "venusRotation": 243,
        "venusRevolution": 224.7,
        "earthRotation": 0.99,
        "earthRevolution": 365.26,
        "marsRotation": 1.03,
        "marsRevolution": 1.88,
        "jupiterRotation": 0.41,
        "jupiterRevolution": 11.86,
        "saturnRotation": 0.45,
        "saturnRevolution": 29.46,
        "uranusRotation": 0.72,
        "uranusRevolution": 84.01,
        "neptuneRotation": 0.67,
        "neptuneRevolution": 164.79
    ]
    
    /**
     On the load, make the background color the "fade" effect, where the
     parent ViewController can still be seen. Also, the `showAnimate()`
     function is instantiated (see docstrings)
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.determinePlanetSpeeds()
        self.showAnimate()
    }
    
    /**
     When the user taps on the popup, the white window will close
     
     - returns:
     Void
     */
    @IBAction func closePopup(_ sender: UITapGestureRecognizer)
    {
        self.removeAnimate()
    }
    
    /**
     Function to determine the speed of the planet dependent on the multiplier and the
     decision of the user (e.g. what planet they pick)
     
     - returns:
     Void
     */
    func determinePlanetSpeeds() -> Void
    {
        // The initial "speed" that was chosen by the user
        var speed: Double!
        // The multiplier that is used to do the calculation of the planet values
        let mult: Double = Singletons.multiplier
        // Determine the speed based on the multiplier. That is to say, if the speed
        // is chosen at 4x, then we will be doing the multiplication calculations by
        // the inverse of this multiplier, and we will display the "actual" speed
        // to the user
        speed = determineSpeed(mult: mult)
        // Constant prefix that starts the beginning of the sentence
        let prefix: String = "Based on the \(speed!)x multiplier chosen, "
        // Perform a switch statement to determine which planet to display
        switch(Singletons.pickerSelection)
        {
            case "Mercury":
                planetsTextView.text = prefix + "Mercury's...\n" +
                        "Rotation Period is \(planetValues["mercuryRotation"]! * mult) " +
                        "Earth days, and its\n" +
                        "Revolution Period is \(planetValues["mercuryRevolution"]! * mult) " +
                        "Earth days."
                break
            case "Venus":
                planetsTextView.text = prefix + "Venus's...\n" +
                    "Rotation Period is \(planetValues["venusRotation"]! * mult) " +
                    "Earth days, and its\n" +
                    "Revolution Period is \(planetValues["venusRevolution"]! * mult) " +
                    "Earth days."
                break
            case "Earth":
                planetsTextView.text = prefix + "Earth's...\n" +
                    "Rotation Period is \(planetValues["earthRotation"]! * mult) " +
                    "Earth days, and its\n" +
                    "Revolution Period is \(planetValues["earthRevolution"]! * mult) " +
                    "Earth days."
                break
            case "Mars":
                planetsTextView.text = prefix + "Mars's...\n" +
                    "Rotation Period is \(planetValues["marsRotation"]! * mult) " +
                    "Earth days, and its\n" +
                    "Revolution Period is \(planetValues["marsRevolution"]! * mult) " +
                    "Earth days."
                break
            case "Jupiter":
                planetsTextView.text = prefix + "Jupiter's...\n" +
                    "Rotation Period is \(planetValues["jupiterRotation"]! * mult) " +
                    "Earth days, and its\n" +
                    "Revolution Period is \(planetValues["jupiterRevolution"]! * mult) " +
                    "Earth days."
                break
            case "Saturn":
                planetsTextView.text = prefix + "Saturn's...\n" +
                    "Rotation Period is \(planetValues["saturnRotation"]! * mult) " +
                    "Earth days, and its\n" +
                    "Revolution Period is \(planetValues["saturnRevolution"]! * mult) " +
                    "Earth days."
                break
            case "Uranus":
                planetsTextView.text = prefix + "Uranus's...\n" +
                    "Rotation Period is \(planetValues["uranusRotation"]! * mult) " +
                    "Earth days, and its\n" +
                    "Revolution Period is \(planetValues["uranusRevolution"]! * mult) " +
                    "Earth days."
                break
            default:
                planetsTextView.text = prefix + "Neptune's...\n" +
                    "Rotation Period is \(planetValues["neptuneRotation"]! * mult) " +
                    "Earth days, and its\n" +
                    "Revolution Period is \(planetValues["neptuneRevolution"]! * mult) " +
                    "Earth days."
                break
        }
    }
    
    /**
     Given a `mult`, or multiplier, determine the speed that has been instantiated by the
     user. This is simply the inverse.
     
     - parameters:
     - mult: The multiplier which we pass in
     
     - returns:
     A double indicating the true "speed", per se
     */
    func determineSpeed(mult: Double) -> Double
    {
        switch mult {
            case 0.03125:
                return 32.0
            case 0.0625:
                return 16.0
            case 0.125:
                return 8.0
            case 0.25:
                return 4.0
            case 0.5:
                return 2.0
            case 1.0:
                return 1.0
            case 2.0:
                return 0.5
            case 4.0:
                return 0.25
            case 8.0:
                return 0.125
            default:
                return 0.0625
        }
    }
    
    /**
     Helper function to animate this view by changing its
     alpha and transform values.
     
     - returns:
     Void
     */
    func showAnimate() -> Void
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    /**
     Helper function to animate this view by changing its
     alpha and transform values. At the end, it removes itself
     from the parent view controller, `PlanetsViewController`
     
     - returns:
     Void
     */
    func removeAnimate() -> Void
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
    }
}
