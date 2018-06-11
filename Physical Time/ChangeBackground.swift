/**
 - Author:
 Xi Stephen Ouyang
 
 Created for Physical Time, 2018
 */

import Foundation
import CoreLocation
import UIKit

/**
 Class that is mainly instantiated to get the "current" background based on the time of
 day
 */
class ChangeBackground
{
    /**
     Using the Solar.swift library, we will determine what time of the day it is and
     dynamically change the background
     
     - returns:
     A string that is the filename identifier for the background, for that time of day.
     */
    func getBackground() -> String
    {
        let coords = CLLocationCoordinate2D.init(latitude: 51.5, longitude: -0.127)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        // Getting date components year, month, day
        let date = Date()
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        // Constructing the string for "today"
        let today = String(year) + "/" + String(month) + "/" + String(day)
        // Getting the date object for `today`
        let someDate = formatter.date(from: today)
        // Instantiating the Solar function to get the sunrise and sunset times
        let solar = Solar.init(for: someDate!, coordinate: coords)
        let sunrise = solar!.sunrise!
        let sunset = solar!.sunset!
        // Getting the interval Date objects
        let sunriseInterval = sunrise.timeIntervalSince1970
        let sunsetInterval = sunset.timeIntervalSince1970
        let daytime = sunsetInterval - sunriseInterval
        let timeInterval = date.timeIntervalSince1970 - 25200
        let oneHourInSeconds: Double = 3600.0
        // Switch statement to determine what time of the day it is, and thus we can
        // dynamically give the name of the background to the caller
        switch (timeInterval)
        {
            case let timeInterval where timeInterval < sunriseInterval:
                return "lunar_pic.jpg"
            case let timeInterval where timeInterval > sunriseInterval
                && timeInterval < (sunriseInterval + oneHourInSeconds):
                return "sunrise.jpg"
            case let timeInterval where timeInterval > sunriseInterval +
                oneHourInSeconds && timeInterval < (sunriseInterval + daytime / 2):
                return "morningGoldenHour.jpeg"
            case let timeInterval where timeInterval > (sunriseInterval + daytime / 2)
                && timeInterval < (sunsetInterval - daytime/4):
                return "noon.jpg"
            case let timeInterval where timeInterval > (sunsetInterval - daytime / 4) &&
                timeInterval < sunsetInterval:
                return "evening.jpg"
            case let timeInterval where timeInterval > sunsetInterval &&
                timeInterval < (sunsetInterval + oneHourInSeconds):
                return "sunset.jpg"
            case let timeInterval where timeInterval > (sunsetInterval + oneHourInSeconds):
                return "lunar_pic.jpg"
            default:
                return "morningGoldenHour.jpeg"
        }
    }
}

