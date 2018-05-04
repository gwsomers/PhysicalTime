/**
 - Author:
 Xi Stephen Ouyang
 Created for Physical Time, 2018
 */

import Foundation
import UIKit

/**
 TODO: Make purpose of class description more descriptive
 Class that extends the UIViewController to give the background.
 */
class MenuView: UIViewController
{
    @IBOutlet weak var goToClockButton: UIButton!
    @IBOutlet weak var goToFeatureButton: UIButton!
    /**
     Do any additional setup after loading the view (specifically, in our case, setting the background).
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
        
        let background = changeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
        
        switch background.getBackground() {
        case "sunrise.jpg":
            goToClockButton.setTitleColor(UIColor.orange, for: .normal);
            goToFeatureButton.setTitleColor(UIColor.orange, for: .normal);
        case "morningGoldenHour.jpg":
            goToClockButton.setTitleColor(UIColor.yellow, for: .normal);
            goToFeatureButton.setTitleColor(UIColor.yellow, for: .normal);
        case "noon.jpg":
            goToClockButton.setTitleColor(UIColor.yellow, for: .normal);
            goToFeatureButton.setTitleColor(UIColor.yellow, for: .normal);
        case "sunset.jpg":
            goToClockButton.setTitleColor(UIColor.orange, for: .normal);
            goToFeatureButton.setTitleColor(UIColor.orange, for: .normal);
        case "night.jpg":
            goToClockButton.setTitleColor(UIColor.orange, for: .normal);
            goToFeatureButton.setTitleColor(UIColor.orange, for: .normal);
        case "lunar_pic.jpg":
            goToClockButton.setTitleColor(UIColor.white, for: .normal);
            goToFeatureButton.setTitleColor(UIColor.white, for: .normal);
            
        default:
            goToClockButton.setTitleColor(UIColor.black, for: .normal);
            goToFeatureButton.setTitleColor(UIColor.black, for: .normal);
        }
    }
}
