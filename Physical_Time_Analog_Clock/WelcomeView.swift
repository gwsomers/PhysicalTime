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
    var defaulthour = 24
    var defaultminute = 60
    var defaultREVDAY = 2
    var defaultREVHOUR = 0
    var defaultANGOFF = 1
    var defaultTIMEOFF = 0.0
    var defaultMODE = 1
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "morningGoldenHour.jpeg")!)
    }
    @IBAction func checkIfNew(_ sender: UIButton) {
        let file = "boring"
        let defaultinfo = "24:60:2:0:1:0:1"
        var recievedinfo=""
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        let fileURL = dir.appendingPathComponent(file).appendingPathExtension("txt")
        do {
            recievedinfo = try String(contentsOf: fileURL,encoding: .utf8)
            let WordsArray = recievedinfo.components(separatedBy: ":")
            var count = 0;
            for sect in WordsArray{
                
            }
        }
            catch{
                do {
                    try defaultinfo.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                }
                catch{}
            }
        }
    }
    
    
}
