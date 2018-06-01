/**
 - Author:
 Xi Stephen Ouyang
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import Hero

/**
 Class that extends the UIViewController to give the background.
 */
class MenuViewController: UIViewController
{
    // All UI elements for this view
    @IBOutlet weak var goToClockButton: UIButton!
    @IBOutlet weak var goToFeatureButton: UIButton!
    @IBOutlet weak var menuInfoButton: UIButton!
    
    /**
     Do any additional setup after loading the view (specifically, in our case, setting the background).
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "menuView"
        // Identifier for the WelcomeView, for the scope of this method
        let welcomeView: UIView! = WelcomeViewController().view
        welcomeView.hero.id = "welcomeView"
        welcomeView.hero.modifiers = [.fade]
        
        // Dynamically change the background
        let background = ChangeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
    }
    
    /**
     At this stage in the view's lifecycle, we shall fade in all UI elements
     and set the font colors for the UI buttons based on the time of day.
     - returns:
     nil
     */
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Do the fades to both UI elements appropriately
        self.goToClockButton.fadeIn(duration: 2.0, delay: 1.0, completion: {
            (finished: Bool) -> Void in
        })
        self.goToFeatureButton.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        
        // Instance of Background
        let background = ChangeBackground()
        // Change the font color of the buttons accordingly
        setFontColor(button: goToFeatureButton,
                     backgroundType: background.getBackground())
        setFontColor(button: goToClockButton,
                     backgroundType: background.getBackground())
    }
    
    /**
     Helper function to set the font color of a button based on the background
     color, that of which is determined by the time of day.
     
     - parameters:
     - button: The button to set the font color
     - backgroundType: The filename extension name of the background, which
        will determine the color of the button
     
     - returns:
     nil
     */
    func setFontColor(button: UIButton, backgroundType: String)
    {
        // Setting the text colors of the respective buttons
        switch backgroundType
        {
            case "sunrise.jpg":
                button.setTitleColor(UIColor.orange, for: .normal);
            case "morningGoldenHour.jpg":
                button.setTitleColor(UIColor.yellow, for: .normal);
            case "noon.jpg":
                button.setTitleColor(UIColor.yellow, for: .normal);
            case "sunset.jpg":
                button.setTitleColor(UIColor.orange, for: .normal);
            case "evening.jpg":
                button.setTitleColor(UIColor.orange, for: .normal);
            case "lunar_pic.jpg":
                button.setTitleColor(UIColor.white, for: .normal);
            default:
                button.setTitleColor(UIColor.black, for: .normal);
            }
    }
}
