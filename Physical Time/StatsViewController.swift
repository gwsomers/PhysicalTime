/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import SwiftySuncalc
import Hero

/**
 Class that extends the UIViewController to tell the user the time of day
 and the next occurrence.
 */
class StatsViewController: UIViewController
{
    // All UI elements for this view
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var thirdTextView: UITextView!
    @IBOutlet weak var fourthTextView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    /**
     On load, dynamically change the background based on the time of day
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instantiating id's for Hero transitions
        self.hero.isEnabled = true
        view.hero.id = "statsView"
        // Identifier for the WelcomeView, for the scope of this method
        let featureView: UIView! = FeatureViewController().view
        featureView.hero.id = "menuView"
        featureView.hero.modifiers = [.fade]
        
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
        
        // Determine the text to set for all of our text views
        self.textView.text = getTime()
        self.secondTextView.text = getAltitude()
        self.thirdTextView.text = getAzimuth()
        self.fourthTextView.text = getMiscMoonData()
        
        self.backButton.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        self.textView.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        self.pageControl.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        
        // Create a background object
        let background = ChangeBackground()
        // Set the font color for our text views
        setFontColor(textView: textView, backgroundType: background.getBackground())
        setFontColor(textView: secondTextView, backgroundType: background.getBackground())
        setFontColor(textView: thirdTextView, backgroundType: background.getBackground())
        setFontColor(textView: fourthTextView, backgroundType: background.getBackground())
    }
    
    /**
     Event listener for the page change on this view controller, which would indicate that
     the user wishes to see the rest of the propagated data. We should switch accordingly.
     We will be fading "by neighbors", if you will
     
     - parameters:
     - sender: An event listener waiting for the page control to be changed, effectively
        passing a UIPageControl element within the function body.
     
     - returns:
     nil
     */
    @IBAction func pageChange(_ sender: UIPageControl)
    {
        // Switch statement to determine which text views to fade out and fade in, so
        // the user may see all the propagated data.
        switch (sender.currentPage)
        {
            // Fade into the first page and out of the second
            case 0:
                self.secondTextView.fadeOut(duration: 0.5, delay: 0.0,  completion: {
                    (finished: Bool) -> Void in
                })
                self.textView.fadeIn(duration: 0.5, delay: 0.5,  completion: {
                    (finished: Bool) -> Void in
                })
            // Fade out of the first page or the third page and into the second
            case 1:
                // Conditional to see which UI element alpha value is currently 1
                if thirdTextView.alpha == CGFloat(1.0)
                {
                    self.thirdTextView.fadeOut(duration: 0.5, delay: 0.0,  completion: {
                        (finished: Bool) -> Void in
                    })
                }
                else
                {
                    self.textView.fadeOut(duration: 0.5, delay: 0.0,  completion: {
                        (finished: Bool) -> Void in
                    })
                }
                // After the fade-out, fade into this second page
                self.secondTextView.fadeIn(duration: 0.5, delay: 0.5,  completion: {
                    (finished: Bool) -> Void in
                })
            
            // Fade out of the second page or the fourth page and into the third page
            case 2:
                // Conditional to see which UI element alpha value is currently 1
                if fourthTextView.alpha == CGFloat(1.0)
                {
                    self.fourthTextView.fadeOut(duration: 0.5, delay: 0.0,  completion: {
                        (finished: Bool) -> Void in
                    })
                }
                else
                {
                    self.secondTextView.fadeOut(duration: 0.5, delay: 0.0,  completion: {
                        (finished: Bool) -> Void in
                    })
                }
                // After the fade-out, fade into this second page
                self.thirdTextView.fadeIn(duration: 0.5, delay: 0.5,  completion: {
                    (finished: Bool) -> Void in
                })
            // Fade out of the third page and into the fourth page
            case 3:
                self.thirdTextView.fadeOut(duration: 0.5, delay: 0.0,  completion: {
                    (finished: Bool) -> Void in
                })
                self.fourthTextView.fadeIn(duration: 0.5, delay: 0.5,  completion: {
                    (finished: Bool) -> Void in
                })
            // Simply make case 0 the default
            default:
                self.secondTextView.fadeOut(duration: 0.5, delay: 0.0,  completion: {
                    (finished: Bool) -> Void in
                })
                self.textView.fadeIn(duration: 0.5, delay: 0.5,  completion: {
                    (finished: Bool) -> Void in
                })
        }
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
            textView.textColor = UIColor.yellow
        case "noon.jpg":
            textView.textColor = UIColor.yellow
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
    
    /**
     Helper function that will tell what time of the day it is and return
     a description to be dynamically loaded into the text view.
     
     - returns:
     A string indicating what will be put in the view in terms of the different
     times of the day.
     */
    func getTime() -> String
    {
        // Declaring a new SwiftySuncalc object
        let suncalc: SwiftySuncalc! = SwiftySuncalc()
        // Today's date/time
        let today: Date! = Date()
        // Get the times for today
        // TODO: Prompt users for their location, hardcoded for now
        var times = suncalc.getTimes(date: today, lat: 37, lng: -122)
        // Identifier to be used in the switch statement below
        var identifier: String!
        // Now, we need to compare the current time with the times given by
        // the Suncalc calculations
        // TODO: Fix the bug in this first conditional (see JavaScript logic from
        // legacy files
        if today < times["nadir"]! && today >= times["night"]!
        {
            identifier = "night"
        }
        else if today >= times["nadir"]! && today < times["nightEnd"]!
        {
            identifier = "nadir"
        }
        else if today >= times["nightEnd"]! && today < times["dawn"]!
        {
            identifier = "small hours"
        }
        else if today >= times["dawn"]! && today < times["sunrise"]!
        {
            identifier = "dawn"
        }
        else if today >= times["sunrise"]! && today < times["sunriseEnd"]!
        {
            identifier = "sunrise"
        }
        else if today >= times["sunriseEnd"]! && today < times["goldenHourEnd"]!
        {
            identifier = "sunrise end"
        }
        else if today >= times["goldenHourEnd"]! && today < times["solarNoon"]!
        {
            identifier = "morning golden hour"
        }
        else if today >= times["solarNoon"]! && today < times["goldenHour"]!
        {
            identifier = "solar noon"
        }
        else if today >= times["goldenHour"]! && today < times["sunsetStart"]!
        {
            identifier = "evening golden hour"
        }
        else if today >= times["sunsetStart"]! && today < times["sunset"]!
        {
            identifier = "sunset"
        }
        else if today >= times["sunset"]! && today < times["dusk"]!
        {
            identifier = "evening twilight"
        }
        else if today >= times["dusk"]! && today < times["night"]!
        {
            identifier = "dusk"
        }
        else if today >= times["nauticalDusk"]! && today < times["night"]!
        {
            identifier = "nautical dusk"
        }
        else
        {
            // In the case of an error, we will leave the identifier equal to nil
        }
        
        // Now, instantiate the switch statement to a return a string back to a caller, to
        // be displayed
        switch identifier
        {
            case "night":
                return "The current state based on the sun's movements is night."
                    + " Night started at \(times["night"]!) GMT. "
                    + "The next occurence will be nadir at \(times["nadir"]!) GMT. "
                    + "We consider it night when it is dark enough for astronomical observations."
            case "nadir":
                return "The current state based on the sun's movements is nadir."
                    + " Nadir started at \(times["nadir"]!) GMT. "
                    + "The next occurence will be small hours at \(times["nightEnd"]!) GMT. "
                    + "Nadir is the darkest moment of the night, where the sun is in its lowest position."
            case "small hours":
                return "The current state based on the sun's movements is small hours."
                    + " Small hours started at \(times["nightEnd"]!) GMT. "
                    + "The next occurence will be dawn at \(times["dawn"]!) GMT. "
                    + "Small hours is the early hours of the morning, after midnight and before dawn."
            case "dawn":
                return "The current state based on the sun's movements is dawn. "
                    + "Dawn started at \(times["dawn"]!) GMT. "
                    + "The next occurence will be sunrise at \(times["sunrise"]!) GMT. "
                    + "Dawn is defined as when the morning nautical twilight ends, and morning civil twilight starts."
            case "sunrise":
                return "The current state based on the sun's movements is sunrise. "
                    + "Sunrise started at \(times["sunrise"]!) GMT. "
                    + "The next occurence will be the morning golden hour at \(times["goldenHourEnd"]!) GMT. "
                    + "Sunrise occurs when the top edge of the sun appears on the horizon."
            case "sunrise end":
                return "The current state based on the sun's movements is the end of sunrise. "
                    + "Sunrise ended at \(times["sunriseEnd"]!) GMT. "
                    + "The next occurence will be the morning golden hour at \(times["goldenHourEnd"]!) GMT. "
                    + "Sunrise occurs when the top edge of the sun appears on the horizon."
            case "morning golden hour":
                return "The current state based on the sun's movements is the morning golden hour. "
                    + "The morning golden hour started at \(times["goldenHourEnd"]!) GMT. "
                    + "The next occurence will be solar noon at \(times["solarNoon"]!) GMT. "
                    + "The morning golden hour is considered soft light by the sun and the best time for photography."
            case "solar noon":
                return "The current state based on the sun's movements is solar noon. "
                    + "Solar noon started at \(times["solarNoon"]!) GMT. "
                    + "The next occurence will be the evening golden hour at \(times["goldenHour"]!) GMT. "
                    + "We are considered in solar noon when the sun is in the highest position."
            case "evening golden hour":
                return "The current state based on the sun's movements is the evening golden hour. "
                    + "The evening golden hour started at \(times["goldenHour"]!) GMT. "
                    + "The next occurence will be sunset at \(times["sunsetStart"]!) GMT. "
                    + "The evening golden hour is considered soft light by the sun and the best time for photography prior to sunset."
            case "sunset":
                return "The current state based on the sun's movements is sunset. "
                    + "Sunset started at \(times["sunsetStart"]!) GMT. "
                    + "The next occurence will be the evening twilight at \(times["sunset"]!) GMT. "
                    + "Sunset is when the sun disappears below the horizon and evening civil twilight starts."
            case "evening twilight":
                return "The current state based on the sun's movements is evening twilight. "
                    + "Evening twilight started at \(times["sunset"]!) GMT. "
                    + "The next occurence will be dusk at \(times["dusk"]!) GMT. "
                    + "Evening twilight is when the sun fully submerges before the horizon, right before dusk."
            case "dusk":
                return "The current state based on the sun's movements is dusk. "
                    + "Dusk started at \(times["dusk"]!) GMT. "
                    + "The next occurence will be nautical dusk at \(times["nauticalDusk"]!) GMT. "
                    + "Dusk is when the evening nautical twilight starts."
            case "nautical dusk":
                return "The current state based on the sun's movements is nautical dusk. "
                    + "Nautical dusk started at \(times["nauticalDusk"]!) GMT. "
                    + "The next occurence will be <u>the beginning of night at \(times["night"]!) GMT. "
                    + "Nautical dusk is when the evening astronomical twilight starts."
            default:
                return "Oops! Something seems to be broken! Sorry about that! Please report this" + " bug at https://github.com/gwsomers/PhysicalTime. Thank you for your"
                    + " understanding!"
        }
    }
    
    /**
     Helper function to get the moon and sun altitude.
     
     - parameters:
     - lat: The latitude of the user, expressed as a Double
     - lng: The longitude of the user, expressed as a Double
     
     - returns:
     A formatted string with the moon's and sun's altitude.
     */
    func getAltitude(lat: Double = 37.0, lng: Double = -122.0) -> String
    {
        // Declare the string variable to be appended to
        var stringBuilder: String!
        // Declaring a new SwiftySuncalc object
        let suncalc: SwiftySuncalc! = SwiftySuncalc()
        // Today's date/time
        let today: Date! = Date()
        // Get the sun/moon positions and the moon phase
        // TODO: Fix hardcoded latitude and longitude coordinates
        let sunPos = suncalc.getPosition(date: today, lat: lat, lng: lng)
        let moonPos = suncalc.getMoonPosition(date: today, lat: lat, lng: lng)
        // Building the string based on the values returned in the three dictionaries
        stringBuilder = "In the horizontal coordinate system, altitude is the " +
                        "coordinate that measures the height above the horizon (in " +
                        "degrees). The other coordinate is the azimuth. Because the true " +
                        "horizon depends on the local landscape and the exact location of " +
                        "the observer, astronomers often use an \"artificial\" horizon " +
                        "that runs exactly midway between the zenith and nadir.\n" +
                        "Today, the altitude of the sun is " +
                        "\(Double(round(sunPos["altitude"]! * 1000) / 1000))°. " +
                        "The altitude of the moon is " +
                        "\(Double(round(moonPos["altitude"]! * 1000) / 1000))°. " +
                        "\n\n"
        // Return the "built" string
        return stringBuilder
    }
    
    /**
     Helper function to get the moon and sun azimuth.
     
     - parameters:
     - lat: The latitude of the user, expressed as a Double
     - lng: The longitude of the user, expressed as a Double
     
     - returns:
     A formatted string with the moon's and sun's azimuth.
     */
    func getAzimuth(lat: Double = 37.0, lng: Double = -122.0) -> String
    {
        // Declare the string variable to be appended to
        var stringBuilder: String!
        // Declaring a new SwiftySuncalc object
        let suncalc: SwiftySuncalc! = SwiftySuncalc()
        // Today's date/time
        let today: Date! = Date()
        // Get the sun/moon positions
        // TODO: Fix hardcoded latitude and longitude coordinates
        let sunPos = suncalc.getPosition(date: today, lat: lat, lng: lng)
        let moonPos = suncalc.getMoonPosition(date: today, lat: lat, lng: lng)
        // Building the string based on the values returned in the three dictionaries
        stringBuilder = "The azimuth is the coordinate from the horizontal coordinate " +
                        "system that indicates the direction along the horizon. The " +
                        "azimuth is measured in degrees, but not everyone uses the same " +
                        "range of azimuth or the same zero point. Sometimes the azimuth " +
                        "is measured between −180 and +180°, sometimes between 0 and 360°, " +
                        "and sometimes with 0° in the south, and sometimes with 0° in the " +
                        "north. For astronomical application it is convenient to set 0° " +
                        "in the south and to measure azimuth between −180 and +180°: that " +
                        "provides the best fit to the hour angle.\n" +
                        "Today, the azimuth of the sun is " +
                        "\(Double(round(sunPos["azimuth"]! * 1000) / 1000))°. " +
                        "The aziumth of the moon is " +
                        "\(Double(round(moonPos["azimuth"]! / 1000) / 1000))°."
        // Return the "built" string
        return stringBuilder
    }
    
    /**
     Helper function to get miscellaneous moon data, such as the distance, parallactic angle,
     and moon phase.
     
     - parameters:
     - lat: The latitude of the user, expressed as a Double
     - lng: The longitude of the user, expressed as a Double
     
     - returns:
     A formatted string with the miscellaneous moon data, as priorly mentioned.
     */
    func getMiscMoonData(lat: Double = 37.0, lng: Double = -122.0) -> String
    {
        // Declare the string variable to be appended to
        var stringBuilder: String!
        // Declaring a new SwiftySuncalc object
        let suncalc: SwiftySuncalc! = SwiftySuncalc()
        // Today's date/time
        let today: Date! = Date()
        // Get the sun/moon positions and the moon phase
        let moonPos = suncalc.getMoonPosition(date: today, lat: lat, lng: lng)
        let moonIllumination = suncalc.getMoonIllumination(date: today)
        
        stringBuilder = "The distance to the moon from your latitude/longitude coordinates " +
                        "is \(moonPos["distance"]!) kilometers.\n" +
                        "The parallactic angle, as defined as the angle between the great " +
                        "circle through a celestial object and the zenith, and the hour " +
                        "circle of the objec. The parallactic angle of the moon is " +
                        "\(moonPos["parallacticAngle"]!) radians.\nThe current moon phase " +
                        "is \(getMoonPhase(moonPhaseVal: moonIllumination["phase"]!))"
        
        return stringBuilder
    }
    
    /**
     This is a helper function that will get the moon phase value between 0.0 and 1.0 and
     return a formatted string to finish the caller's sentence, if you will. Phases are
     interpreted as follows:
     Phase    Name
     0      New Moon
            Waxing Crescent
     0.25   First Quarter
            Waxing Gibbous
     0.5    Full Moon
            Waning Gibbous
     0.75   Last Quarter
            Waning Crescent
     * See more at https://github.com/cristiangonzales/SwiftySuncalc/blob/master/README.md
     
     - parameters:
     - moonPhaseVal: A double value between 0 and 1 indicating the moon phase.
     
     - returns:
     A formatted string to finish the sentence, where the caller lies.
     */
    func getMoonPhase(moonPhaseVal: Double) -> String
    {
        switch moonPhaseVal
        {
            case let moonPhaseVal where moonPhaseVal < 0.125:
                return "New Moon, which is defined as the first lunar phase, when the Moon " +
                    "and Sun have the same ecliptic longitude. At this phase, the lunar " +
                    "disk is not visible to the unaided eye, except when silhouetted " +
                    "during a solar eclipse."
            case let moonPhaseVal where moonPhaseVal >= 0.125 && moonPhaseVal < 0.25:
                return "Waxing Cresent, where the Moon starts as the Moon becomes visible " +
                        "again after the New Moon conjunction, when the Sun and Earth were " +
                        "on opposite sides of the Moon, making it impossible to see the " +
                        "Moon from Earth."
            case let moonPhaseVal where moonPhaseVal >= 0.25 && moonPhaseVal < 0.375:
                return "First Quarter, where we can see exactly half of the Moon's surface " +
                        "illuminated. If it is the left or right half, depends on where " +
                        "you are on Earth."
            case let moonPhaseVal where moonPhaseVal >= 0.375 && moonPhaseVal < 0.5:
                return "Waxing Gibbous, which occurs just after the First Quarter Moon, " +
                        "when we can see exactly half of the face of the Moon illuminated, " +
                        "the intermediate phase called Waxing Gibbous Moon starts."
            case let moonPhaseVal where moonPhaseVal >= 0.5 && moonPhaseVal < 0.625:
                return "Full Moon, which is defined as the lunar phase when the Moon " +
                        "appears fully illuminated from Earth's perspective. This occurs " +
                        "when Earth is located directly between the Sun and the Moon."
            case let moonPhaseVal where moonPhaseVal >= 0.625 && moonPhaseVal < 0.75:
                return "Waning Gibbous, which is defined as the lunar phase or phase of " +
                        "the Moon is the shape of the directly sunlit portion of the Moon " +
                        "as viewed from Earth."
            case let moonPhaseVal where moonPhaseVal >= 0.75 && moonPhaseVal < 0.875:
                return "Last Quarter, which is defined as a moon that always rises in " +
                    "the middle of the night, appears at its highest in the sky " +
                    "around dawn, and sets around midday. At last quarter, the lunar " +
                    "disk appears half-lit in sunshine and half-immersed in the moon's " +
                    "own shadow."
            default:
                return "Waning Cresent, where the illuminated part of the Moon decreases " +
                        "from the lit up semicircle at Third Quarter until it disappears " +
                        "from view entirely at New Moon."
        }
    }
}
