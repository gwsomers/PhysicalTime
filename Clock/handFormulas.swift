//
//  handPosition.swift
//  Physical_Time_Analog_Clock
//
//  Created by George Somers on 2/18/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//


//parts means hours.

import Foundation

class Hand_Positioner{
    var partsPerDay: Int
    var partsOnFace: Int
    var partRevsPerDay: Int
    var ticksPerPart: Int
    var tickRevsPerPart: Int
    var FaceResetOffset: Float //enter the angle away from TOP, so to reset at the right
    //would be pi/2
    var TimeResetOffset: Int  //How many seconds away from noon we are starting the clock at
    
    init(pPD: Int, pRPD: Int, tPP: Int, tRPP: Int, fRO:Float, tRO: Int){
        partsPerDay = pPD
        partsOnFace = pPD/pRPD
        partRevsPerDay = pRPD
        ticksPerPart = tPP
        tickRevsPerPart = tRPP
        FaceResetOffset = fRO
        TimeResetOffset = tRO
    }
    
    //Calcs where the arm is angled at given a start time.
    //Useful when initializing clock
    func partAngle (timeHour:Int, timeMin:Int, timeSec:Int)->Float{
        var totalTime :Int
        totalTime = timeSec + (timeMin * 60) + (timeHour * 3600)
        totalTime = TimeResetOffset + totalTime
        let fullDay = 24*60*60
        let portionOfDay:Float = Float(totalTime)/Float(fullDay)
        return (2 * Float(Double.pi) * portionOfDay) * Float(partRevsPerDay) + FaceResetOffset
        
    }
    //Time it takes for a 360 degree turn of our clock's part hand, in seconds. Can be used to find
    //Animation speed
    func partDuration()->Int{
        return Int(24*60*60) / partRevsPerDay
    }
    
    func tickAngle(timeHour:Int, timeMin:Int, timeSec:Int)->Float{
        var totalTime :Int
        totalTime = timeSec + (timeMin * 60) + (timeHour * 3600) + TimeResetOffset
        let partTime : Int = ((24*60*60)/partsPerDay)
        totalTime %= partTime
        let portionOfPart:Float = Float(totalTime)/Float(partTime)
        return (2 * Float(Double.pi) * portionOfPart) * Float(tickRevsPerPart) + FaceResetOffset
    }
    func tickDuration()->Int{
        return Int(24*60*60)/(partsPerDay * tickRevsPerPart)
    }
    
    
}


