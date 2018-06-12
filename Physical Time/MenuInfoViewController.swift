/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import Hero

/**
 Class representing the view controller that gives more info/premise past the
 MenuViewController
 */
class MenuInfoViewController: UIViewController
{
    @IBOutlet weak var menuInfoTextView: UITextView!
    /**
     On load, dynamically change the background based on the time of day and
     change the
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "menuInfoView"
        // Identifier for the MenuView, for the scope of this method
        let menuView: UIView! = MenuViewController().view
        menuView.hero.id = "menuView"
        menuView.hero.modifiers = [.fade]
        
        // Changing the background
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
        
        // Do the fades to all UI elements appropriately
        self.menuInfoTextView.fadeIn(duration: 2.0, delay: 1.0, completion: {
            (finished: Bool) -> Void in
        })
        
        // Create a background object
        let background = ChangeBackground()
        // Set the font color for our text views
        setFontColor(textView: menuInfoTextView, backgroundType: background.getBackground())
    }
    
    /**
     Helper function to set the font color of the text view based on the background
     color, that of which is determined by the time of day.
     
     - parameters:
     - textView: The text to set the font color
     - backgroundType: The filename extension name of the background, which
     will determine the color of the button
     
     - returns:
     nil
     */
    func setFontColor(textView: UITextView, backgroundType: String)
    {
        // Setting the text colors of the respective buttons
        switch backgroundType
        {
        case "sunrise.jpg":
            textView.textColor = UIColor.orange
        case "morningGoldenHour.jpg":
            textView.textColor = UIColor.black
        case "noon.jpg":
            textView.textColor = UIColor.black
        case "sunset.jpg":
            textView.textColor = UIColor.orange
        case "evening.jpg":
            textView.textColor = UIColor.orange
        case "lunar_pic.jpg":
            textView.textColor = UIColor.white
        default:
            textView.textColor = UIColor.black
        }
    }
}

