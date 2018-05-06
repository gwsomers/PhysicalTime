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
    
    var firstTime=true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "morningGoldenHour.jpeg")!)
    }
    @IBAction func checkIfNew(_ sender: UIButton) {
       // if firstTime == true{
        
        //self.performSegue(withIdentifier: "firstTime", sender: self)
       // }
       /* else{
        self.performSegue(withIdentifier: "notfirst", sender: self)
        }*/
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if let ident = segue.identifier {
                if ident == "first"{
                let menuViewController = segue.destination as! SettingsViewController
                }
                else{
                let menuViewController = segue.destination as! ViewController
                }
            }
        }
    
    
}
