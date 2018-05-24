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
        let background = changeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
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
                else{
                let menuViewController = segue.destination as! ViewController
                }
            }
        }
        }*/
    }
    
    
}
