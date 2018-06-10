/**
 - Author:
 Xi Stephen Ouyang
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import Hero


/**
 Class that extends the UIViewController to give the background for the time of day
 and welcomes the user.
 */
class WelcomeViewController: UIViewController
{
    // Main title for the opening view, "Physical Time"
    @IBOutlet weak var mainTitle: UILabel!
    
    /**
     On load, dynamically change the background based on the time of day
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "welcomeView"
        
        // Dynamically change the background on the load
        let background = ChangeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
    }
    
    /**
     On this stage of the app lifecycle, make the UI elements fade in
     - returns:
     nil
     */
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Do the fades to both UI elements appropriately
        // Do the fades to both UI elements appropriately
        self.mainTitle.fadeIn(duration: 3.0, delay: 1.0)
        self.mainTitle.fadeOut(duration: 3.0, delay: 4.0, completion: {
            (finished: Bool) -> Void in
            // On the closure, instantiate the transition to the menu view controller
            let menuViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "menuVC")
                    as? MenuViewController
            self.present(menuViewController!, animated: true, completion: nil)
        })
    }
}
