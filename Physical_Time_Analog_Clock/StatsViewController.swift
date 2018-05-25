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
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textView: UITextView!

    /**
     On load, dynamically change the background based on the time of day
     - returns:
     nil
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
        
        // Set the alphas of the page elements to 0 initially (such that they
        // remain hidden initially)
        self.menuButton.alpha = 0
        self.backButton.alpha = 0
        self.textView.alpha = 0
        
        // Determine the text to set for our textView
        self.textView.text = getDescription()
        
        // Do the fades to both UI elements appropriately
        self.menuButton.fadeIn(duration: 2.0, delay: 1.0, completion: {
            (finished: Bool) -> Void in
        })
        self.backButton.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        self.textView.fadeIn(duration: 2.0, delay: 1.0,  completion: {
            (finished: Bool) -> Void in
        })
        
        // Create a background object
        let background = ChangeBackground()
        // Set the font color for our text view
        setFontColor(textView: textView, backgroundType: background.getBackground())
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
     A string indicating what will be put in the
     */
    func getDescription() -> String
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
}
