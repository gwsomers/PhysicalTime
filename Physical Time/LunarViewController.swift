/**
 - Author:
 Stephen Ouyang, Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import UIKit
import SwiftySuncalc
//import SwiftSoup

/**
 Class for the Lunar view controller.
 
 TODO: Find an API or formulaic solution to finding the next lunar eclipse relative to
 the user's coordinates. This is currrently hardcoded.
 */
class LunarViewController: UIViewController {
    
    // All the UI components for this display
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var currentMoonPhase: UILabel!
    // Class variables for our class
    var seconds = 0;
    var timer = Timer();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Using Hero transition
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "lunarView"
        // Identifier for the MenuView, for the scope of this method
        let menuView: UIView! = MenuViewController().view
        menuView.hero.id = "menuView"
        menuView.hero.modifiers = [.fade]
        
        // Initializing the background programmatically
        self.view.backgroundColor = UIColor(
            patternImage: UIImage(named: "lunar_pic")!)
        // Find the amount of seconds until the next eclipse
        updateSecondsForEclipse()
        // Instantiate the timer and dynamic filling of the `lunarEclipseLabel` label
        runTimer()
        // Instantiate the image for the moon cycle
        initLunarCycleImage()
    }
    
    /**
     Initializer that updates the number of `seconds` (the class variable). Called every
     second by the timed function.
     
     - returns:
     Void
     */
    func updateSecondsForEclipse() -> Void
    {
        // Get the year, month, and date for today
        let today: Date = Date()
        // Next eclipse, as a date object
        var nextEclipse: Date = Date()
        // Dictionary to hold all eclipses (2018-2020)
        // (via
        let eclipsesForNextDecade: [Date] = [
            getDate(year: 2018, month: 7, day: 27,
                    zone: "UTC", hour: 20,
                    minute: 22, second: 54),
            getDate(year: 2019, month: 1, day: 21,
                        zone: "UTC", hour: 5,
                        minute: 13, second: 27),
            getDate(year: 2019, month: 7, day: 16,
                        zone: "UTC", hour: 21,
                        minute: 31, second: 55),
            getDate(year: 2020, month: 1, day: 10,
                        zone: "UTC", hour: 19,
                        minute: 11, second: 11),
            getDate(year: 2020, month: 6, day: 5,
                        zone: "UTC", hour: 19,
                        minute: 26, second: 14),
            getDate(year: 2020, month: 7, day: 5,
                        zone: "UTC", hour: 4,
                        minute: 31, second: 12),
            getDate(year: 2020, month: 11, day: 30,
                        zone: "UTC", hour: 4,
                        minute: 31, second: 12)
        ]
        
        // Iterate through all the date objects for eclipses in the next decade. Since,
        // without loss of generality, the dates are ordered in the array, we can set
        // the date of the next eclipse to that date
        for date in eclipsesForNextDecade
        {
            if today < date
            {
                nextEclipse = date
                break
            }
        }
        // Now, we can extrapolate the data of the date and subtract it from today (in
        // seconds), and then set the `seconds` class variable equal to this
        seconds = Int(nextEclipse.timeIntervalSince1970) -
                                Int(today.timeIntervalSince1970)
    }
    
    /**
     Simpler helper function to determine if a month or day value needs a "0" appended to
     its string for the URL.
     
     - parameters:
     - dateValue: The value of the month or day, as a String
     
     - returns:
     An appended 0 to the original value passed in if it was originally a length of 1,
     or returns it if it is two characters long
     */
    func makeDateValuesTwoDigits(dateValue: String) -> String
    {
        if dateValue.count == 1
        {
            return "0" + dateValue
        }
        else
        {
            return dateValue
        }
    }
    
    /**
     Each countdown will divide the respective metric (i.e. month, day, etc.) by the amount
     of seconds in that metric, x, and take the modulus of how many there is of that
     metric x in the greater component. For instance, if we are trying to find minutes,
     we will divide `time` by the amount of secodns in a minute, and mod the result
     by the amount of minutes in an hour.
     
     - parameters:
     - time: The current amount of time, in seconds
     
     - returns:
     A mutable string with the amount of months, days, hours, minutes, and seconds,
     in a countdown fashion
     */
    func countdownString(time: TimeInterval) -> String
    {
        
        var daysInAMonth: Int!
        // Determine the current month, to divide by the amount of days in a month
        let currentMonth = Calendar.current.component(.month, from: Date())
        // If the current month falls on September, April, June, or November, there
        // are 30 days in the month, and if not, there are 31
        if currentMonth == 4 || currentMonth == 6 || currentMonth == 9 ||
            currentMonth == 11
        {
            daysInAMonth = 30
        }
        else
        {
            daysInAMonth = 31
        }
        // Initialize months, days, hours, minutes, and seconds accordingly
        let months = Int(time) / 2629746 % 12
        let days = Int(time) / 86400 % daysInAMonth
        let hours = Int(time) / 3600 % 24
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i:%02i:%02i", months, days,
                      hours, minutes, seconds);
    }
    
    /**
     Using the SwiftySuncalc library, we can determine the lunar phase based on the
     value given and initialize a `UIImageView` object with the object initialized
     to the correct moon to be displayed.
     
     - returns:
     Void
     */
    func initLunarCycleImage() -> Void
    {
        // Get the lunar phase based on today's date
        let phase = SwiftySuncalc()
                        .getMoonIllumination(date: Date())["phase"]
        // Initialize the lunar image view to be an empty `UIImageView` object
        // with no pictures initialized
        var lunarImageView = UIImageView();
        
        // Switch statement to determine which phase we're in, and initializes
        // the empty `lunarImageView` and the `currentMoonPhase` label view and
        // text
        switch phase
        {
            case let x where x! <= 0.125:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "new_moon.png")!);
                currentMoonPhase.text = "New Moon"
                break;
            case let x where x! >= 0.126 && x! <= 0.25:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "waxing_crescent.png")!)
                currentMoonPhase.text = "Waxing Crescent"
                break;
            case let x where x! >= 0.251 && x! <= 0.375:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "1st_quarter.png")!);
                currentMoonPhase.text = "First Quarter"
                break;
            case let x where x! >= 0.376 && x! <= 0.50:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "waxing_gibbous.png")!);
                currentMoonPhase.text = "Waxing Gibbous"
                break;
            case let x where x! >= 0.51 && x! <= 0.625:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "moon.png")!);
                currentMoonPhase.text = "Full Moon"
                break;
            case let x where x! >= 0.626 && x! <= 0.750:
                lunarImageView = UIImageView(image:
                                UIImage(named: "waning_gibbous.png")!);
                currentMoonPhase.text = "Waning Gibbous"
                break;
            case let x where x! >= 0.751 && x! <= 0.875:
                lunarImageView = UIImageView(image:
                                UIImage(named: "third_quarter.png")!);
                currentMoonPhase.text = "Third Quarter"
                break;
            case let x where x! >= 0.876 && x! <= 1:
                lunarImageView = UIImageView(image:
                                UIImage(named: "waning_crescent.png")!);
                currentMoonPhase.text = "Waning Crescent"
                break;
            default:
                break;
        }
        // TODO: Fix magic numbers 4 & 3.. why does this work?
        lunarImageView.frame = CGRect(x: self.view.frame.size.width / 4,
                                      y: self.view.frame.size.height / 3,
                                      width: 200, height: 200)
        view.addSubview(lunarImageView)
    }
    
    /**
     Helper function to instantiate the timer and make the `updateTimer` function
     run at a certain time interval.
     
     - returns:
     Void
     */
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LunarViewController.updateTimer), userInfo: nil, repeats: true);
    }
    
    /**
     Helper function that runs at a scheduled time interval to update the labels
     according to the time.
     
     - returns:
     Void
     */
    @objc func updateTimer()
    {
        // Decrease the seconds value
        seconds -= 1;
        if seconds >= 0
        {
            countdownLabel.text = countdownString(time: TimeInterval(seconds));
        }
        else
        {
            // TODO: Reset all values and UI elements to display the next
            // image
        }
    }
    
    /**
     Helper function to construct a custom date object.
     See: https://stackoverflow.com/a/33344575/4883617
     
     - parameters:
     - year: Specified year as an integer of length 4
     - month: Specified month as an integer of length 1 or 2
     - day: Specified day as an integer of length 1 or 2
     - zone: Specified time zone, as an string of length 1-3
     - hour: Specified hour as an integer of length 1 or 2
     - minute: Specified minute as an integer of length 1 or 2
     - second: Specified second as an integer of length 1 or 2
     
     - returns:
     Swift Date() object with the custom parameters specified by the caller.
     */
    func getDate(year: Int, month: Int, day: Int, zone: String,
                     hour: Int, minute: Int, second: Int) -> Date
    {
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        // Time zone specified by caller
        dateComponents.timeZone = TimeZone(abbreviation: zone)
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        // Create date from components
        return Calendar.current.date(from: dateComponents)!
    }
}
