//
//  handPosition.swift
//  Physical_Time_Analog_Clock
//
//  Created by George Somers on 2/18/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import Foundation
import CoreLocation

let NOON_MODE = 1
let DAWN_MODE = 2

public struct defaultHandValues {
    static let hoursPerDay = "hoursPerDay"
    static let hourRevsPerDay = "hourRevsPerDay"
    static let minsPerHour = "minsPerHour"
    static let minRevsPerHour = "minRevsPerHour"
    static let FaceOffset = "faceOffset"
    static let TimeOffset = "timeOffset"
    static let mode = "mode"
}

class HandFormulas{
    var hoursPerDay: Int
    var hoursOnFace: Int
    var hourRevsPerDay: Int
    var minutesPerhour: Int
    var minuteRevsPerhour: Int
    var FaceResetOffset: Float //enter the angle away from TOP, so to reset at the right
    //would be pi/2
    var TimeResetOffset: Int  //How many seconds away from noon we are starting the clock at
    //The clockmode decides our anchor point, currently accepts noon and dawn
    var Clockmode: Int
    var locationManager: CLLocationManager

    
    
    init(pPD: Int = 24, pRPD: Int = 2, tPP: Int = 60, tRPP: Int = 1, fRO:Float = 0, tRO: Int = 0, mode: Int = NOON_MODE, locMan: CLLocationManager){
        hoursPerDay = pPD
        hoursOnFace = pPD/pRPD
        hourRevsPerDay = pRPD
        minutesPerhour = tPP
        minuteRevsPerhour = tRPP
        FaceResetOffset = fRO
        TimeResetOffset = tRO
        Clockmode = mode
        locationManager = locMan

        
        
    }
    //Calcs where the arm is angled at given a start time.
    //Useful when initializing clock
    func hourAngle (timeHour:Int, timeMin:Int, timeSec:Int)->Float{
        var totalTime :Int
        totalTime = timeSec + (timeMin * 60) + (timeHour * 3600)
        totalTime = TimeResetOffset + totalTime + getModeOffset()
        let fullDay = getFullDay()
        let portionOfDay:Float = Float(totalTime)/Float(fullDay)
        print("portionOfDay: ", portionOfDay)
        print(fullDay)
        print(totalTime)
        return (2 * Float(Double.pi) * portionOfDay) * Float(hourRevsPerDay) + FaceResetOffset
        
    }
    //Time it takes for a 360 degree turn of our clock's hour hand, in seconds. Can be used to find
    //Animation speed
    func hourDuration()->Int{
        return getFullDay() / hourRevsPerDay
    }
    
    func minuteAngle(timeHour:Int, timeMin:Int, timeSec:Int)->Float{
        var totalTime :Int
        totalTime = timeSec + (timeMin * 60) + (timeHour * 3600) + TimeResetOffset + getModeOffset()
        let hourTime : Int = (getFullDay()/hoursPerDay)
        totalTime %= hourTime
        let portionOfhour:Float = Float(totalTime)/Float(hourTime)
        return (2 * Float(Double.pi) * portionOfhour) * Float(minuteRevsPerhour) + FaceResetOffset
    }
    func minuteDuration()->Int{
        return getFullDay()/(hoursPerDay * minuteRevsPerhour)
    }
    
    func getModeOffset()->Int{
        var modeOffset = 0
        if(Clockmode == DAWN_MODE){
            modeOffset = -getDawn(myDate: NSDate() as Date)
        }
        print("modeOffset: ", modeOffset)
        return modeOffset
    }
    //TODO: Find how much time will be had by a dawn mode clock
    func getFullDay()->Int{
        if(Clockmode == DAWN_MODE){
            return 24*60*60 - ((getDawn(myDate: NSDate() as Date)) -
                getDawn(myDate: Date.init(timeInterval: 24*3600, since: NSDate() as Date)))
        }
        return 24*60*60
    }
    //TODO: Implement Cris' method for dawn finding
    func getDawn(myDate: Date)->Int{
        var coords = CLLocationCoordinate2D.init(latitude: 39.37, longitude: 122.03)
        print(locationManager.location?.coordinate as Any)
        if(CLLocationManager.locationServicesEnabled())
        {
            coords = locationManager.location!.coordinate
        }
        
        let Solarcalc = Solar.init(for: myDate, coordinate: coords)

        let sunriseUTC = Solarcalc!.sunrise!
        var startoftoday = Date.init(timeIntervalSinceReferenceDate: 0)
        while (startoftoday.timeIntervalSinceReferenceDate < sunriseUTC.timeIntervalSinceReferenceDate)
        {
            startoftoday = Date.init(timeInterval: 24*3600, since: startoftoday)
        }
        startoftoday = Date.init(timeInterval: -24*3600, since: startoftoday)
        print("seconds to dawn: ", (sunriseUTC.timeIntervalSince(startoftoday)-(8*60*60)))
        return (Int(sunriseUTC.timeIntervalSince(startoftoday)))
    }
    
    func convertToTimezone(time: TimeInterval)->TimeInterval{
        return time + (-8*60*60)
    
    }
    
    
}
