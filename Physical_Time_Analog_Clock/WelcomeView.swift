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
class WelcomeView: UIViewController
{
    /**
     Do any additional setup after loading the view (specifically, in our case, setting the background).
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "morningGoldenHour.jpeg")!)
    }
}
