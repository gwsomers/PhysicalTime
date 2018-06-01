/**
 - Author:
 Khai Hua
 Created for Physical Time, 2018
 */

import UIKit
import Foundation
import Hero

/**
 Page with listed features.
 */
class FeatureViewController: UIViewController
{
    // UI elements for this view
    @IBOutlet weak var lunarFeatureButton: UIButton!
    @IBOutlet weak var wadokeiFeatureButton: UIButton!
    @IBOutlet weak var planetaryVisButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var featureInfoButton: UIButton!
    
    /**
     Change the background dynamically on a load.
     
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "featureView"
        // Identifier for the WelcomeView, for the scope of this method
        let menuView: UIView! = MenuViewController().view
        menuView.hero.id = "menuView"
        menuView.hero.modifiers = [.fade]
        
        let background = ChangeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
    }
    
    
    /**
     Change the button text dynamically on a load.
     
     - returns:
     nil
     */
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Do the fades to all UI elements appropriately
        self.lunarFeatureButton.fadeIn(duration: 2.0, delay: 1.0, completion: {
            (finished: Bool) -> Void in
        })
        self.wadokeiFeatureButton.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        self.planetaryVisButton.fadeIn(duration: 2.0, delay: 1.0, completion: {
            (finished: Bool) -> Void in
        })
        self.statsButton.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        self.menuButton.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        
        // Create a background object
        let background = ChangeBackground()
        // Set the font colors accordingly
        setFontColor(button: lunarFeatureButton,
                     backgroundType: background.getBackground())
        setFontColor(button: wadokeiFeatureButton,
                     backgroundType: background.getBackground())
        setFontColor(button: planetaryVisButton,
                     backgroundType: background.getBackground())
        setFontColor(button: statsButton,
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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
