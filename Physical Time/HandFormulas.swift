/**
 - Author:
 George Somers
 
 Created for Physical Time, 2018
 */

import Foundation
import CoreLocation

/**
 Here, the different hand formulas can be found for the main augmentable clockface. This,
 of course, is dynamically defined by the user.
 */
class HandFormulas
{
    // Class variables, used to initialize the different time metrics
    let numOfSecondsInADay: Int = 24 * 60 * 60
    var hoursPerDay: Int
    var hoursOnFace: Int
    var hourRevsPerDay: Int
    var minutesPerhour: Int
    var minuteRevsPerhour: Int
    // Enter the angle away from TOP, so to reset at the right would be pi/2
    var FaceResetOffset: Float
    // How many seconds away from noon we are starting the clock at
    var TimeResetOffset: Int
    // The clockmode decides our anchor point, currently accepts noon and dawn
    var clockMode: Int

    /**
     Class constructor initializing the different time metrics
     
     - parameters:
     - hoursPerDay: The amount of hours per day, as defined by the user
     - hourRevsPerDay: The amount of hour revolutions it takes for one user
                        defined hour, for the day
     - minutesPerHour: The amount of minutes per hour, as defined by the user
     - minuteRevsPerhour: The amount of minute revolutions it takes for one user
                            defined hour, for the day
     - faceResetOffset: TODO
     - mode: What mode it is (see `Singletons` file)
     
     */
    init(hoursPerDay: Int = 24, hourRevsPerDay: Int = 2, minutesPerHour: Int = 60,
         minuteRevsPerhour: Int = 1, faceResetOffset:Float = 0, timeResetOffset: Int = 0,
         mode: Int = Singletons.NOON_MODE)
    {
        self.hoursPerDay = hoursPerDay
        self.hoursOnFace = hoursPerDay / hourRevsPerDay
        self.hourRevsPerDay = hourRevsPerDay
        self.minutesPerhour = minutesPerHour
        self.minuteRevsPerhour = minuteRevsPerhour
        self.FaceResetOffset = faceResetOffset
        self.TimeResetOffset = timeResetOffset
        self.clockMode = mode
    }
    
    /**
     Calculations for where the hour hand is angled at given a start time.
     
     - parameters:
     - timeHour: The current hour defined by the caller, defined as an integer
     - timeMin: The current minute defined by the caller, defined as an integer
     - timeSec: The current second defined by the caller, defined as an integer
     
     - returns:
     The angle of which the hour hand should be tilted/rotated, as a float
     */
    func hourAngle (timeHour: Int, timeMin: Int, timeSec: Int) -> Float
    {
        let totalTime: Int = TimeResetOffset + timeSec + (timeMin * 60) +
                            (timeHour * 3600) + getModeOffset()
        let portionOfDay: Float = Float(totalTime) / Float(getFullDay())
        return (2 * Float.pi * portionOfDay)
                    * Float(hourRevsPerDay) + FaceResetOffset
    }
    
    /**
     Time it takes for a 360 degree turn of our clock's hour hand, in seconds.
     Can be used to find the animation speed.
     
     - returns:
     An integer indicating the "direction" of an hour and
     */
    func hourDuration() -> Int
    {
        return getFullDay() / hourRevsPerDay
    }
    
    /**
     Calculations for where the minute hand is angled at given a start time.
     
     - parameters:
     - timeHour: The current hour defined by the caller, defined as an integer
     - timeMin: The current minute defined by the caller, defined as an integer
     - timeSec: The current second defined by the caller, defined as an integer
     
     - returns:
     The angle of which the minute hand should be tilted/rotated, as a float
     */
    func minuteAngle(timeHour: Int, timeMin: Int, timeSec: Int) -> Float
    {
        let totalTime: Int = timeSec + (timeMin * 60) +
                            (timeHour * 3600) + TimeResetOffset + getModeOffset()
        let hourTime : Int = (getFullDay() / hoursPerDay)
        let portionOfhour: Float = Float(totalTime % hourTime) / Float(hourTime)
        return (2 * Float(Double.pi) * portionOfhour) * Float(minuteRevsPerhour) + FaceResetOffset
    }
    
    /**
     Get the duration of a minute in a day, dependent on the defined time in a day (dependant
     on what mode it is in) divided by the defined hours in the day (defined in constructor
     by the caller) and the `minRevsPerhour` (see docstrings in constructor)
     
     - returns:
     An integer with the minute duration based on user defined metrics
     */
    func minuteDuration() -> Int
    {
        return getFullDay() / (hoursPerDay * minuteRevsPerhour)
    }
    
    func getModeOffset()->Int{
        var modeOffset = 0
        if(clockMode == Singletons.DAWN_MODE)
        {
            modeOffset = -getDawn(myDate: NSDate() as Date)
        }
        return modeOffset
    }
    /**
     Returns the amount of seconds that will be in a day, dependent on if there is a "dawn"
     mode or not.
     
     - returns:
     The amount of seconds on one entire day (of course, dependent on the clock mode chosen)
     */
    func getFullDay() -> Int
    {
        // If the clock mode is in dawn, then get the offset from the dawn function
        if(clockMode == Singletons.DAWN_MODE)
        {
            return numOfSecondsInADay - getDawn(myDate: NSDate() as Date) -
                getDawn(myDate: Date.init(timeInterval: Double(numOfSecondsInADay),
                                          since: NSDate() as Date))
        }
        // If not, simply return the true number of seconds in one day
        return numOfSecondsInADay
    }
    
    /**
     The dawn function that defines the clock for the "start of the day" for dawn mode
     
     - parameters:
     - myDate: The date, as defined by the caller
     
     - returns:
     An integer indicating... (TODO)
     */
    func getDawn(myDate: Date) -> Int
    {
        // Initialize the solar object from the given date and coordinates, dependant on
        // if the user gave their coordinates
        let coords = Singletons.coords
        // Initialize the Solar object
        let Solarcalc = Solar.init(for: myDate, coordinate: coords!)
        // Get the sunrise time in UTC
        let sunriseUTC = Solarcalc!.sunrise!
        var startoftoday = Date.init(timeIntervalSinceReferenceDate: 0)
        while (startoftoday.timeIntervalSinceReferenceDate < sunriseUTC.timeIntervalSinceReferenceDate)
        {
            startoftoday = Date.init(timeInterval: Double(numOfSecondsInADay),
                                     since: startoftoday)
        }
        startoftoday = Date.init(timeInterval: Double(-numOfSecondsInADay),
                                 since: startoftoday)
        return Int(sunriseUTC.timeIntervalSince(startoftoday))
    }
    
    /**
     TODO: Fill in docstrings
     */
    func convertToTimezone(time: TimeInterval) -> TimeInterval
    {
        return time + (-8 * 60 * 60)
    }
}
