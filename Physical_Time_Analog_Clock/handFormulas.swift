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

class Hand_Positioner{
    var partsPerDay: Int
    var partsOnFace: Int
    var partRevsPerDay: Int
    var ticksPerPart: Int
    var tickRevsPerPart: Int
    var FaceResetOffset: Float //enter the angle away from TOP, so to reset at the right
    //would be pi/2
    var TimeResetOffset: Int  //How many seconds away from noon we are starting the clock at
    //The clockmode decides our anchor point, currently accepts noon and dawn
    var Clockmode: Int
    var locationManager: CLLocationManager

    
    
    init(pPD: Int = 24, pRPD: Int = 2, tPP: Int = 60, tRPP: Int = 1, fRO:Float = 0, tRO: Int = 0, mode: Int = NOON_MODE, locMan: CLLocationManager){
        partsPerDay = pPD
        partsOnFace = pPD/pRPD
        partRevsPerDay = pRPD
        ticksPerPart = tPP
        tickRevsPerPart = tRPP
        FaceResetOffset = fRO
        TimeResetOffset = tRO
        Clockmode = mode
        locationManager = locMan
        getDawn(myDate: NSDate() as Date)
        
        
    }
    //Calcs where the arm is angled at given a start time.
    //Useful when initializing clock
    func partAngle (timeHour:Int, timeMin:Int, timeSec:Int)->Float{
        var totalTime :Int
        totalTime = timeSec + (timeMin * 60) + (timeHour * 3600)
        totalTime = TimeResetOffset + totalTime + getModeOffset()
        let fullDay = getFullDay()
        let portionOfDay:Float = Float(totalTime)/Float(fullDay)
        print("portionOfDay: ", portionOfDay)
        print(fullDay)
        print(totalTime)
        return (2 * Float(Double.pi) * portionOfDay) * Float(partRevsPerDay) + FaceResetOffset
        
    }
    //Time it takes for a 360 degree turn of our clock's part hand, in seconds. Can be used to find
    //Animation speed
    func partDuration()->Int{
        return getFullDay() / partRevsPerDay
    }
    
    func tickAngle(timeHour:Int, timeMin:Int, timeSec:Int)->Float{
        var totalTime :Int
        totalTime = timeSec + (timeMin * 60) + (timeHour * 3600) + TimeResetOffset + getModeOffset()
        let partTime : Int = (getFullDay()/partsPerDay)
        totalTime %= partTime
        let portionOfPart:Float = Float(totalTime)/Float(partTime)
        return (2 * Float(Double.pi) * portionOfPart) * Float(tickRevsPerPart) + FaceResetOffset
    }
    func tickDuration()->Int{
        return getFullDay()/(partsPerDay * tickRevsPerPart)
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
