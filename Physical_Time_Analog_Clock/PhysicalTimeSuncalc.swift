/**
 - Author:
 Cristian Gonzales
 Created for Physical Time, 2018
 */

import Foundation

/**
 - Important:
 This class is ported from https://github.com/mourner/suncalc
 
 - Version:
 0.1
 
 - License:
 MIT License
 
 Copyright (c) 2018 Cristian Gonzales
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 TODO:
 - Better document and understand the functions from the suncalc.js library
 */
class PhysicalTimeSuncalc
{
    // Simple conventions
    let PI: Double = Double.pi
    let rad: Double = Double.pi / 180
    
    // Date/time conversions (Julian time)
    let dayMs: Double = 1000 * 60 * 60 * 24
    let J1970: Double = 2440588.0
    let J2000: Double = 2451545.0
    
    // Obliquity of the Earth
    let e: Double = (Double.pi / 180) * 23.4397

    /**
     Conversion of the current date to Julian
     - parameters:
        - date: a Date() object passed by the callee
     - returns:
     A double calculating the date in Julian, in milliseconds
     */
    func toJulian(date: Date) -> Double
    {
        return Double(Date().millisecondsSince1970) / dayMs - 0.5 + J1970
    }
    
    /**
     Conversion of a given date from Julian (double) to a date object (1970 and onward)
     - parameters:
        - j: an integer offset to calculate the date in milliseconds
     - returns:
     A date object for any specified Julian value
     */
    func fromJulian(j: Double) -> Date
    {
        return Date(milliseconds: Int((j + 0.5 - J1970) * dayMs))
    }
    
    /**
     Conversion of a date object to a double number of the amount of days
     - parameters:
        - date: a Date() object passed by the callee
     - returns:
     A double value for the total amount of days.
     */
    func toDays(date: Date) -> Double
    {
        return toJulian(date: date) - J2000
    }
    
    /**
     General calculation for positioning (right ascension)
     - parameters:
        - l: TODO
        - b: TODO
     - return:
    A double indicating the right acension given the appropriate function arguments
     */
    func rightAscension(l: Double, b: Double) -> Double
    {
        // TODO
//        return atan(sin(l) * cos(e) - tan(b) * sin(e), cos(l))
        return 0.0
    }
    
    init()
    {
        
    }
}

/**
 Date extension to obtain the Date since 1970, and to get the time interval since 1970 in milli (the latter init() method call)
 (see https://stackoverflow.com/a/40135192)
 
 - usage:
 Date().millisecondsSince1970 // 1476889390939
 Date(milliseconds: 0) // "Dec 31, 1969, 4:00 PM" (PDT variant of 1970 UTC)
 */
extension Date
{
    // Extended functionality to get milliseconds from 1970 to present time
    var millisecondsSince1970:Int
    {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    // Obtaining the time interval since 1970 for a given amount of milliseconds
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
