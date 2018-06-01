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
class WelcomeViewController: UIViewController
{
    // Main title for the opening view, "Physical Time"
    @IBOutlet weak var mainTitle: UILabel!
    // The button to proceed to the next view
    @IBOutlet weak var menuContinue: UIButton!
    // The button that will transition to the info
    // view for the Welcome view
    @IBOutlet weak var welcomeInfoButton: UIButton!
    
    /**
     On load, dynamically change the background based on the time of day
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Dynamically change the background on the load
        let background = ChangeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
    }
    
    /**
     On this stage of the app lifecycle, make the UI elements fade in
     - returns:
     nil
     */
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
