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
    /**
     On the load, make the background color the "fade" effect, where the
     parent ViewController can still be seen. Also, the `showAnimate()`
     function is instantiated (see docstrings)
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
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
