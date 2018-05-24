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
    var defaultANGOFF = Float(1.0)
    var defaultTIMEOFF = 0
    var defaultMODE = 1
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let background = changeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
    }
    @IBAction func checkIfNew(_ sender: UIButton) {
        /*let file = "boring"
        let defaultinfo = "24:60:2:0:1:0:1"
        var recievedinfo=""
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        let fileURL = dir.appendingPathComponent(file).appendingPathExtension("txt")
        do {
            recievedinfo = try String(contentsOf: fileURL,encoding: .utf8)
            let WordsArray = recievedinfo.components(separatedBy: ":")
            var count = 0;
            for sect in WordsArray{
                if count == 0{
                    let dh: String = sect
                    defaulthour = Int(dh)!
                }
                if count == 1{
                    let dh: String = sect
                    defaultminute = Int(dh)!
                }
                if count == 2{
                    let dh: String = sect
                    defaultREVDAY = Int(dh)!
                }
                if count == 3{
                    let dh: String = sect
                    defaultREVHOUR = Int(dh)!
                }
                if count == 4{
                    let dh: String = sect
                    defaultANGOFF = Float(dh)!
                }
                if count == 5{
                    let dh: String = sect
                    defaultTIMEOFF = Int(dh)!
                }
                if count == 6{
                    let dh: String = sect
                    defaultMODE = Int(dh)!
                }
                count = count + 1
            }
        }
            catch{
                do {
                    try defaultinfo.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                }
                catch{}
            }
        }*/
    }
    
    
}
