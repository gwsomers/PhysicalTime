/**
 - Author:
 Xi Stephen Ouyang
 Created for Physical Time, 2018
 */

/*
 Transferral of info from 1 view to another.
 
 Segueway -
 class variables -
 */
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var hoursPerDayText: UITextField!
    @IBOutlet weak var minutesPerHourText: UITextField!
    @IBOutlet weak var revolutionPerDayText: UITextField!
    @IBOutlet weak var minutesRevolutionPerHourText: UITextField!
    @IBOutlet weak var angleOffsetText: UITextField!
    @IBOutlet weak var timeOffsetText: UITextField!
    @IBOutlet weak var modeText: UITextField!
    @IBOutlet weak var fname: UITextField!
    
    
    @IBAction func buttonTap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToClock", sender: self)
    }
    @IBAction func export(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToClockE", sender: self)
    }
    @IBAction func importing(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToClockI", sender: self)
    }
    
    // called right before segueway occurs on current ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let identifier = segue.identifier {
            if identifier == "segueToClock" {
                let defaults = UserDefaults.standard
                let clockViewController = segue.destination as! ViewController
                clockViewController.hoursPerDay = Int(hoursPerDayText.text!)
                defaults.set(Int(hoursPerDayText.text!), forKey: defaultHandValues.hoursPerDay)
                clockViewController.minutesPerHour = Int(minutesPerHourText.text!)
                defaults.set(Int(minutesPerHourText.text!), forKey: defaultHandValues.minsPerHour)
                clockViewController.revolutionPerDay = Int(revolutionPerDayText.text!)
                defaults.set(Int(revolutionPerDayText.text!), forKey: defaultHandValues.hourRevsPerDay)
                clockViewController.minuteRevolutionPerHour = Int(minutesRevolutionPerHourText.text!)
                defaults.set(Int(minutesRevolutionPerHourText.text!), forKey: defaultHandValues.minRevsPerHour)
                clockViewController.angleOffset = Float(angleOffsetText.text!)
                defaults.set(Float(angleOffsetText.text!), forKey: defaultHandValues.FaceOffset)
                clockViewController.timeOffset = Int(timeOffsetText.text!)
                defaults.set(Int(timeOffsetText.text!), forKey: defaultHandValues.TimeOffset)
                clockViewController.mode = Int(modeText.text!)
                defaults.set(Int(modeText.text!), forKey: defaultHandValues.mode)
            }
            else if identifier == "segueToClockE" {
                let defaults = UserDefaults.standard
                let clockViewController = segue.destination as! ViewController
                clockViewController.hoursPerDay = Int(hoursPerDayText.text!)
                defaults.set(Int(hoursPerDayText.text!), forKey: defaultHandValues.hoursPerDay)
                clockViewController.minutesPerHour = Int(minutesPerHourText.text!)
                defaults.set(Int(minutesPerHourText.text!), forKey: defaultHandValues.minsPerHour)
                clockViewController.revolutionPerDay = Int(revolutionPerDayText.text!)
                defaults.set(Int(revolutionPerDayText.text!), forKey: defaultHandValues.hourRevsPerDay)
                clockViewController.minuteRevolutionPerHour = Int(minutesRevolutionPerHourText.text!)
                defaults.set(Int(minutesRevolutionPerHourText.text!), forKey: defaultHandValues.minRevsPerHour)
                clockViewController.angleOffset = Float(angleOffsetText.text!)
                defaults.set(Float(angleOffsetText.text!), forKey: defaultHandValues.FaceOffset)
                clockViewController.timeOffset = Int(timeOffsetText.text!)
                defaults.set(Int(timeOffsetText.text!), forKey: defaultHandValues.TimeOffset)
                clockViewController.mode = Int(modeText.text!)
                defaults.set(Int(modeText.text!), forKey: defaultHandValues.mode)
                exportSettings(fileName: String(fname.text!), hour: Int(hoursPerDayText.text!)!, minute: Int(minutesPerHourText.text!)!, rev: Int(revolutionPerDayText.text!)!, mrph: Int(minutesRevolutionPerHourText.text!)!, angle: Float(angleOffsetText.text!)!, timeoff: Int(timeOffsetText.text!)!, mode: Int(modeText.text!)!)
            }
            else if identifier == "segueToClockI" {
                let clockViewController = segue.destination as! ViewController
                let information = importSettings(fileName : String(fname.text!))
                let WordsArray = information.components(separatedBy: ":")
                var count = 0;
                for sect in WordsArray{
                    if count == 0{
                        let dh: String = sect
                        clockViewController.hoursPerDay = Int(dh)!
                        defaults.set(Int(dh)!, forKey: defaultHandValues.hoursPerDay)
                    }
                    if count == 1{
                        let dh: String = sect
                        clockViewController.minutesPerHour = Int(dh)!
                        defaults.set(Int(dh)!, forKey: defaultHandValues.minsPerHour)
                    }
                    if count == 2{
                        let dh: String = sect
                        clockViewController.revolutionPerDay = Int(dh)!
                        defaults.set(Int(dh)!, forKey: defaultHandValues.hourRevsPerDay)
                    }
                    if count == 3{
                        let dh: String = sect
                        clockViewController.minuteRevolutionPerHour = Int(dh)!
                        defaults.set(Int(dh)!, forKey: defaultHandValues.minRevsPerHour)
                    }
                    if count == 4{
                        let dh: String = sect
                        clockViewController.angleOffset = Float(dh)!
                        defaults.set(Float(dh)!, forKey: defaultHandValues.FaceOffset)
                    }
                    if count == 5{
                        let dh: String = sect
                        clockViewController.timeOffset = Int(dh)!
                        defaults.set(Int(dh)!, forKey: defaultHandValues.TimeOffset)
                    }
                    if count == 6{
                        let dh: String = sect
                        clockViewController.mode = Int(dh)!
                        defaults.set(Int(dh)!, forKey: defaultHandValues.mode)
                    }
                    count = count + 1
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let background = ChangeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
