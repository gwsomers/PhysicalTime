/**
 - Author:
 Xi Stephen Ouyang
 
 Created for Physical Time, 2018
 */

import UIKit
import Hero

/**
 TODO: Add docstrings and refactor for readability/code cleanliness
 */
class SettingsViewController: UIViewController
{
    // UI text field elements for the class
    @IBOutlet weak var hoursPerDayText: UITextField!
    @IBOutlet weak var minutesPerHourText: UITextField!
    @IBOutlet weak var revolutionPerDayText: UITextField!
    @IBOutlet weak var minutesRevolutionPerHourText: UITextField!
    @IBOutlet weak var angleOffsetText: UITextField!
    @IBOutlet weak var timeOffsetText: UITextField!
    @IBOutlet weak var modeText: UITextField!
    @IBOutlet weak var fname: UITextField!
    // UI label elements for the class
    @IBOutlet weak var hoursPerDayLabel: UILabel!
    @IBOutlet weak var minutesPerHourLabel: UILabel!
    @IBOutlet weak var minuteRevolutionPerHourLabel: UILabel!
    @IBOutlet weak var revolutionPerDayLabel: UILabel!
    @IBOutlet weak var angleOffsetLabel: UILabel!
    @IBOutlet weak var timeOffsetLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var pathLabel: UILabel!
    @IBOutlet weak var exportLabel: UILabel!
    @IBOutlet weak var importLabel: UILabel!
    @IBOutlet weak var clipboardLabel: UILabel!
    
    /**
     Upon the back button tap, you will return to the augmented clock
     
     - returns:
     Void
     */
    @IBAction func buttonTap(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "segueToClock", sender: self)
    }
    
    /**
     Upon the export button tap, you will return to the augmented clock
     
     - returns:
     Void
     */
    @IBAction func exportButton(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "segueToClockE", sender: self)
    }

    /**
     Upon the import button tap, you will make the appropriate changes to
     the augemented clock
     
     - returns:
     Void
     */
    @IBAction func importButton(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "segueToClockI", sender: self)
    }
    
    /**
     When the button is pressed, this function will instantiate the child
     view controller, `SettingsClipboardViewController`.
     
     - parameters:
     - sender: The event where the button is pressed
     
     - returns:
     Void
     */
    @IBAction func copyToCliopboard(_ sender: UIButton)
    {
        // Declare `popupViewController` to represent the
        // `SettingsClipboardViewController`
        let popupViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "copyToClipboard")
            as! SettingsClipboardViewController
        // Declare `popupViewController` to be a child of this view controller
        self.addChildViewController(popupViewController)
        popupViewController.view.frame = self.view.frame
        self.view.addSubview(popupViewController.view)
        popupViewController.didMove(toParentViewController: self)
    }
    
    /*
     Called right before segueway occurs on current ViewController
     
     TODO: Complete docstrings and refactor this function completely
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Declaration of a transferSettings object to transfer settings
        let transferSettings = TransferSettings()
        if let identifier = segue.identifier
        {
            // Segue to return to the clock as determined by button tap
            if identifier == "segueToClock"
            {
                let defaults = UserDefaults.standard
                let clockViewController = segue.destination as! ViewController
                clockViewController.hoursPerDay = Int(hoursPerDayText.text!)
                defaults.set(Int(hoursPerDayText.text!), forKey: Singletons.hoursPerDay)
                clockViewController.minutesPerHour = Int(minutesPerHourText.text!)
                defaults.set(Int(minutesPerHourText.text!), forKey: Singletons.minsPerHour)
                clockViewController.revolutionPerDay = Int(revolutionPerDayText.text!)
                defaults.set(Int(revolutionPerDayText.text!), forKey: Singletons.hourRevsPerDay)
                clockViewController.minuteRevolutionPerHour = Int(minutesRevolutionPerHourText.text!)
                defaults.set(Int(minutesRevolutionPerHourText.text!), forKey: Singletons.minRevsPerHour)
                clockViewController.angleOffset = Float(angleOffsetText.text!)
                defaults.set(Float(angleOffsetText.text!), forKey: Singletons.FaceOffset)
                clockViewController.timeOffset = Int(timeOffsetText.text!)
                defaults.set(Int(timeOffsetText.text!), forKey: Singletons.TimeOffset)
                clockViewController.mode = Int(modeText.text!)
                defaults.set(Int(modeText.text!), forKey: Singletons.mode)
            }
            // Exporting segue as determined by button tap
            else if identifier == "segueToClockE"
            {
                let defaults = UserDefaults.standard
                let clockViewController = segue.destination as! ViewController
                clockViewController.hoursPerDay = Int(hoursPerDayText.text!)
                defaults.set(Int(hoursPerDayText.text!), forKey: Singletons.hoursPerDay)
                clockViewController.minutesPerHour = Int(minutesPerHourText.text!)
                defaults.set(Int(minutesPerHourText.text!), forKey: Singletons.minsPerHour)
                clockViewController.revolutionPerDay = Int(revolutionPerDayText.text!)
                defaults.set(Int(revolutionPerDayText.text!), forKey: Singletons.hourRevsPerDay)
                clockViewController.minuteRevolutionPerHour = Int(minutesRevolutionPerHourText.text!)
                defaults.set(Int(minutesRevolutionPerHourText.text!), forKey: Singletons.minRevsPerHour)
                clockViewController.angleOffset = Float(angleOffsetText.text!)
                defaults.set(Float(angleOffsetText.text!), forKey: Singletons.FaceOffset)
                clockViewController.timeOffset = Int(timeOffsetText.text!)
                defaults.set(Int(timeOffsetText.text!), forKey: Singletons.TimeOffset)
                clockViewController.mode = Int(modeText.text!)
                defaults.set(Int(modeText.text!), forKey: Singletons.mode)
                transferSettings.exportSettings(fileName: String(fname.text!), hour: Int(hoursPerDayText.text!)!, minute: Int(minutesPerHourText.text!)!, rev: Int(revolutionPerDayText.text!)!, mrph: Int(minutesRevolutionPerHourText.text!)!, angle: Float(angleOffsetText.text!)!, timeoff: Int(timeOffsetText.text!)!, mode: Int(modeText.text!)!)
            }
            // Importing segue as determined by button tap
            else if identifier == "segueToClockI"
            {
                let clockViewController = segue.destination as! ViewController
                let information = transferSettings.importSettings(fileName : String(fname.text!))
                let WordsArray = information.components(separatedBy: ":")
                var count = 0;
                for sect in WordsArray{
                    if count == 0{
                        let dh: String = sect
                        clockViewController.hoursPerDay = Int(dh)!
                        defaults.set(Int(dh)!, forKey: Singletons.hoursPerDay)
                    }
                    if count == 1{
                        let dh: String = sect
                        clockViewController.minutesPerHour = Int(dh)!
                        defaults.set(Int(dh)!, forKey: Singletons.minsPerHour)
                    }
                    if count == 2{
                        let dh: String = sect
                        clockViewController.revolutionPerDay = Int(dh)!
                        defaults.set(Int(dh)!, forKey: Singletons.hourRevsPerDay)
                    }
                    if count == 3{
                        let dh: String = sect
                        clockViewController.minuteRevolutionPerHour = Int(dh)!
                        defaults.set(Int(dh)!, forKey: Singletons.minRevsPerHour)
                    }
                    if count == 4{
                        let dh: String = sect
                        clockViewController.angleOffset = Float(dh)!
                        defaults.set(Float(dh)!, forKey: Singletons.FaceOffset)
                    }
                    if count == 5{
                        let dh: String = sect
                        clockViewController.timeOffset = Int(dh)!
                        defaults.set(Int(dh)!, forKey: Singletons.TimeOffset)
                    }
                    if count == 6{
                        let dh: String = sect
                        clockViewController.mode = Int(dh)!
                        defaults.set(Int(dh)!, forKey: Singletons.mode)
                    }
                    count = count + 1
                }
            }
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "settingsView"
        // Identifier for the WelcomeView, for the scope of this method
        let mainView: UIView! = ViewController().view
        mainView.hero.id = "mainView"
        mainView.hero.modifiers = [.fade]
        
        // Change the background of the view
        let background = ChangeBackground()
        self.view.backgroundColor = UIColor(patternImage: UIImage(
                                    named: background.getBackground())!)
        // Change all labels accordingly
        setLabelColor(label: hoursPerDayLabel,
                     backgroundType: background.getBackground())
        setLabelColor(label: minutesPerHourLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: minuteRevolutionPerHourLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: revolutionPerDayLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: angleOffsetLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: timeOffsetLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: modeLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: pathLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: exportLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: importLabel,
                      backgroundType: background.getBackground())
        setLabelColor(label: clipboardLabel,
                      backgroundType: background.getBackground())
    }
    
    /**
     Helper function to set the font color of the `UILabel` element based on the
     background color, that of which is determined by the time of day.
     
     - parameters:
     - label: The text to set the font color
     - backgroundType: The filename extension name of the background, which
     will determine the color of the label
     
     - returns:
     nil
     */
    func setLabelColor(label: UILabel, backgroundType: String)
    {
        // Setting the text colors of the respective buttons
        switch backgroundType
        {
            case "sunrise.jpg":
                label.textColor = UIColor.orange
            case "morningGoldenHour.jpg":
                label.textColor = UIColor.black
            case "noon.jpg":
                label.textColor = UIColor.black
            case "sunset.jpg":
                label.textColor = UIColor.orange
            case "evening.jpg":
                label.textColor = UIColor.orange
            case "lunar_pic.jpg":
                label.textColor = UIColor.white
            default:
                label.textColor = UIColor.black
            }
    }
}
