/**
 - Author:
 Xi Stephen Ouyang
 Created for Physical Time, 2018
 */

import Foundation
import UIKit


/**
 Class that extends the UIViewController to give the background for the time of day
 and welcomes the user.
 */
class WelcomeView: UIViewController
{
    // Main title for the opening view, "Physical Time"
    @IBOutlet weak var mainTitle: UILabel!
    // The button to proceed to the next view
    @IBOutlet weak var menuContinue: UIButton!
    
    /**
     On load, dynamically change the background based on the time of day
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let background = changeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set the alphas of the page elements to 0 initially (such that they
        // remain hidden initially)
        self.mainTitle.alpha = 0
        self.menuContinue.alpha = 0
        
        // Do the fades to both UI elements appropriately
        self.mainTitle.fadeIn(duration: 3.0, delay: 1.0, completion: {
            (finished: Bool) -> Void in
        })
        self.menuContinue.fadeIn(duration: 2.0, delay: 4.5,  completion: {
            (finished: Bool) -> Void in
        })
        
    }
}

/**
 Fileprivate extenstion to perform fading in and fading out of elements in the
 view. See https://stackoverflow.com/a/46459103
 */
extension UIView
{
    /**
     Fading in of a given UIView component
     - parameters:
     - duration: The duration of the fade (takes TimeInterval arg)
     - delay: The time offset of the fade (takes TimeInterval arg)
     - completion: Callback to perform code after the completion of the fade
     
     - returns:
     nil
     */
    func fadeIn(duration: TimeInterval, delay: TimeInterval, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in})
    {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    /**
     Fading out of a given UIView component
     - parameters:
     - duration: The duration of the fade (takes TimeInterval arg)
     - delay: The time offset of the fade (takes TimeInterval arg)
     - completion: Callback to perform code after the completion of the fade
     
     - returns:
     nil
     */
    func fadeOut(duration: TimeInterval, delay: TimeInterval, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in})
    {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
